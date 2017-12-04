--v2.2
--v1.0

create or replace trigger CUX_IC_LOCT_INV_TRG
  before insert or update on "GMI"."IC_LOCT_INV"
  for each row
		
DECLARE
		p_ITEM_UM VARCHAR2(100);
		p_ITEM_UM2 VARCHAR2(100);
		
		P_ITEM_NO VARCHAR2(100); --ADD BY JSJ_HKX 20160823 FOR 仓库 TN11% 非 CGTH% 货位，且在物料范围内的 批次状态都 变为 可用 START--
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
	:NEW.loct_onhand2:=ROUND(:NEW.loct_onhand2,8);--add by jsj_hkx 20170626 for px 销售关单数量不匹配，导致无法关单
	
  --ADD BY JSJ_HKX 20160817 FOR CGTH% 货位 批次状态都 变为 待检 START--
  IF :NEW.LOCATION LIKE 'CGTH%'
    THEN
      :NEW.LOT_STATUS:='待检';
    END IF;
  --ADD BY JSJ_HKX 20160817 FOR CGTH% 货位 批次状态都 变为 待检 START--  
  
  --ADD BY JSJ_HKX 20160823 FOR 仓库 TN11% 非 CGTH% 货位，且在物料范围内的 批次状态都 变为 可用 START--
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
      :NEW.LOT_STATUS:='可用';
    END IF;
  --ADD BY JSJ_HKX 20160823 FOR 仓库 TN11% 非 CGTH% 货位，且在物料范围内的 批次状态都 变为 可用 END--  
  
	--ADD BY JSJ_HKX 20170122 FOR 股份精粮材料厂 NFT1 采购接收物料的  批次状态都 变为 可用 START--
	IF  :NEW.WHSE_CODE LIKE 'NFT1'
   
    THEN
      :NEW.LOT_STATUS:='可用';
    END IF;
		--ADD BY JSJ_HKX 20170122 FOR 股份精粮材料厂 NFT1 采购接收物料的  批次状态都 变为 可用 END--
  	
END CUX_IC_LOCT_INV_TRG;
/
