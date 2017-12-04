--v2.0
--V1.0

CREATE OR REPLACE Function get_item_cost(l_item_id     Number,
                                         l_period_code Date,
                                         l_whse_code   varchar2)
  Return Number Is

  v_cost      Number; 
  oa_item_id  number;
  v_whse_code varchar2(20);
  v_item_uom1 varchar2(4);
  v_item_uom2 varchar2(4);
  v_co_code   varchar2(10);

Begin
  ----------ȡ OA item id 
  select distinct INVENTORY_ITEM_ID
  into   oa_item_id
  from   MTL_SYSTEM_ITEMS_B a,
         ic_item_mst_b      b
  where  a.segment1 = b.item_no
  and    b.item_id = l_item_id;

  ----------ȡ�ɱ��ֿ⣻
  select distinct cux_cst_develop_pkg.GET_COST_WHSE(l_WHSE_CODE,
                                                    NULL)
  INTO   v_whse_code
  FROM   DUAL;
  BEGIN
    -- ȡ��˾id
    -- LCJ  2008-07-09 ���ӹ�˾��
    select l.organization_id
    into   v_co_code
    from   HR_OPERATING_UNITS l
    where  exists (select s.OPERATING_UNIT
            from   org_organization_definitions s,
                   ic_whse_mst                  t
            where  s.ORGANIZATION_ID = t.MTL_ORGANIZATION_ID
            and    t.whse_code = l_whse_code
            and    l.organization_id = s.OPERATING_UNIT);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN(0);
  END;
  ---��λ
  select im.item_um,
         im.item_um2
  into   v_item_uom1,
         v_item_uom2
  from   ic_item_mst_b im
  where  im.item_id = l_item_id;

  begin
  
  
  /*
  
              <----ǰ      |    ��---->
  -------------------------|----------------------------->
                           |                          ʱ��
                     ������ʱ��
  
   �Ȳ���������ʱ��֮ǰ���������ʱ��ĳɱ���
    �� ȡ�ɱ�ֵ��
    û�У�
      ��������ʱ��֮ǰ���������ʱ��Ĳɹ����ۣ�
       �� ȡ�ɹ����ۣ�
       û�У�
          ��������ʱ��֮�����������ʱ��ĳɱ���
          �� ȡ�ɱ�ֵ��
          û�У�
             ��������ʱ��֮�����������ʱ��Ĳɹ����ۣ�
             �� ȡ�ɹ����ۣ�
             û�� ���� 0 ��
                                             lcj 2008-10-22      
  */
    if cux_develop_lcj_cost_pkg.find_acctg_cost(p_item_id     => l_item_id,
                                                p_period_code => l_period_code,
                                                p_whse_code   => v_whse_code,
                                                P_status      => 'ǰ')
    then
      v_cost := cux_develop_lcj_cost_pkg.get_acctg_cost(p_item_id     => l_item_id,
                                                        p_period_code => l_period_code,
                                                        p_whse_code   => v_whse_code,
                                                        P_status      => 'ǰ');
    else
      if cux_develop_lcj_cost_pkg.find_po_cost(p_item_id     => oa_item_id,
                                               p_period_code => l_period_code,
                                               p_co_code     =>  v_co_code,
                                               P_status      => 'ǰ')
      then
        v_cost := cux_develop_lcj_cost_pkg.get_po_cost(p_item_id     => oa_item_id,
                                                       P_OPM_ITEM_ID => l_item_id,
                                                       p_item_uom1   => v_item_uom1,
                                                       p_period_code => l_period_code,
                                                       p_co_code     => v_co_code,
                                                       P_status      => 'ǰ');
      else
        if cux_develop_lcj_cost_pkg.find_acctg_cost(p_item_id     => l_item_id,
                                                    p_period_code => l_period_code,
                                                    p_whse_code   => v_whse_code,
                                                    P_status      => '��')
        then
          v_cost := cux_develop_lcj_cost_pkg.get_acctg_cost(p_item_id     => l_item_id,
                                                            p_period_code => l_period_code,
                                                            p_whse_code   => v_whse_code,
                                                            P_status      => '��');
        else
          if cux_develop_lcj_cost_pkg.find_po_cost(p_item_id     => oa_item_id,
                                                   p_period_code => l_period_code,
                                                   p_co_code     =>  v_co_code,
                                                   P_status      => '��')
          then
            v_cost := cux_develop_lcj_cost_pkg.get_po_cost(p_item_id     => oa_item_id,
                                                           P_OPM_ITEM_ID => l_item_id,                 
                                                           p_item_uom1   => v_item_uom1,
                                                           p_period_code => l_period_code,
                                                           p_co_code     => v_co_code,
                                                           P_status      => '��');
          else
            v_cost := 0;
          
          end if;
        
        end if;
      
      end if;
    
    end if;
  return (v_cost);
  
  exception
    when others then
      v_cost:=0;
      return (v_cost);
  end;

End get_item_cost;
/
