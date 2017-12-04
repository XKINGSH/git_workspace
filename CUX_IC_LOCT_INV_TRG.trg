--v2.2
--v1.0

create or replace trigger CUX_IC_LOCT_INV_TRG
  before insert or update on "GMI"."IC_LOCT_INV"
  for each row
		
DECLARE
		p_ITEM_UM VARCHAR2(100);
		p_ITEM_UM2 VARCHAR2(100);
		
		P_ITEM_NO VARCHAR2(100); --ADD BY JSJ_HKX 20160823 FOR �ֿ� TN11% �� CGTH% ��λ���������Ϸ�Χ�ڵ� ����״̬�� ��Ϊ ���� START--
BEGIN
	IF NVL(:NEW.LOCT_ONHAND,-1) <> -1
		THEN
			:NEW.LOCT_ONHAND:=ROUND(:NEW.LOCT_ONHAND,8);--6
	END IF;
	
	IF :NEW.LOCT_ONHAND2<10
    THEN
      SELECT B.ITEM_UM,B.ITEM_UM2
      INTO p_ITEM_UM,p_ITEM_UM2
       FROM IC_ITEM_MST_B B
      WHERE B.ITEM_ID=:NEW.ITEM_ID
      ;
  IF p_ITEM_UM2 IS NOT NULL
    THEN
   :new.loct_onhand2:=gmicuom.uom_conversion(:new.ITEM_ID,
                                    :new.LOT_ID,
                                    :new.LOCT_ONHAND,
                                    p_ITEM_UM,
                                    p_ITEM_UM2,
                                    0);
	 END IF;
	END IF;
	:NEW.loct_onhand2:=ROUND(:NEW.loct_onhand2,8);--add by jsj_hkx 20170626 for px ���۹ص�������ƥ�䣬�����޷��ص�
	
  --ADD BY JSJ_HKX 20160817 FOR CGTH% ��λ ����״̬�� ��Ϊ ���� START--
  IF :NEW.LOCATION LIKE 'CGTH%'
    THEN
      :NEW.LOT_STATUS:='����';
    END IF;
  --ADD BY JSJ_HKX 20160817 FOR CGTH% ��λ ����״̬�� ��Ϊ ���� START--  
  
  --ADD BY JSJ_HKX 20160823 FOR �ֿ� TN11% �� CGTH% ��λ���������Ϸ�Χ�ڵ� ����״̬�� ��Ϊ ���� START--
  SELECT B.ITEM_NO
      INTO P_ITEM_NO
       FROM IC_ITEM_MST_B B
      WHERE B.ITEM_ID=:NEW.ITEM_ID
      ;
      
  IF :NEW.LOCATION NOT LIKE 'CGTH%'
    AND :NEW.WHSE_CODE LIKE 'TN11'
    AND  
    (P_ITEM_NO LIKE '01-21%'
OR P_ITEM_NO LIKE '01-22%'
OR P_ITEM_NO LIKE '01-31%'
OR P_ITEM_NO LIKE '01-41%')

    THEN
      :NEW.LOT_STATUS:='����';
    END IF;
  --ADD BY JSJ_HKX 20160823 FOR �ֿ� TN11% �� CGTH% ��λ���������Ϸ�Χ�ڵ� ����״̬�� ��Ϊ ���� END--  
  
	--ADD BY JSJ_HKX 20170122 FOR �ɷݾ������ϳ� NFT1 �ɹ��������ϵ�  ����״̬�� ��Ϊ ���� START--
	IF  :NEW.WHSE_CODE LIKE 'NFT1'
   
    THEN
      :NEW.LOT_STATUS:='����';
    END IF;
		--ADD BY JSJ_HKX 20170122 FOR �ɷݾ������ϳ� NFT1 �ɹ��������ϵ�  ����״̬�� ��Ϊ ���� END--
  	
END CUX_IC_LOCT_INV_TRG;
/
