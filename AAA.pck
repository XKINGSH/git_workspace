--v1.0

create or replace package CUX_DEVELOP_NS_PO_PKG is

  -- Author  : KX
  -- Created : 2015-5-5 14:14:27
  -- Purpose : 南沙相关接口
	
	
  -- Public type declarations
  --PX_PO_RCV record
  TYPE R_PO_RCV is record(
    P_FROM_CO_CODE  VARCHAR2(50)--生产的分厂
		,P_TO_CO_CODE  VARCHAR2(50)--采购接收的分厂
		,P_TYPE        VARCHAR2(50)--类型：D:采购接收；R：采购退货；
		,P_PX_ID       NUMBER--瓶箱传入的唯一的id
		,P_PX_LINE_ID       NUMBER--瓶箱传入的 LINE_id
		,P_ITEM_ID     NUMBER--采购接收是净水的话要传入净水的item_id
		,P_LOT_ID      NUMBER
		,P_TRANS_DATE  DATE--采购接收或退货事务时间
		,P_WHSE_CODE   VARCHAR2(50)--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
		,P_LOCATION    VARCHAR2(50)--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
		,P_QTY         NUMBER--接收数量,退货数量，第一单位数量
		,p_um          VARCHAR2(50)--接收数量对应的单位
		,P_REMARK      VARCHAR2(4000)--备注
		,P_USER_NAME   VARCHAR2(50)--用户名，可为空，空的时候默认：CY_ZCM
		,P_SO_NAME_ID     NUMBER--瓶箱传入的 SO_NAME_ID
		);
  
/*===================PX 成品采购接收&退货自动产生事务程序 START==================*/
  /*procedure CREATE_PO_RCV(P_CO_CODE IN VARCHAR2,
		                      P_PO_HEADER_ID IN number
													--,L_
													);*/
													
  procedure CREATE_PO_RETURN(P_WHSE_CODE IN VARCHAR2
                          ,P_RCV_NO IN VARCHAR2
													,P_ITEM_ID  IN NUMBER
													,P_LOT_ID   IN NUMBER
									        ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
													,P_WHSE_CODE_ON  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
													,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
													,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
													,p_um         IN VARCHAR2--接收数量对应的单位
													,P_REMARK     IN VARCHAR2--备注
                  ,p_vendor_lot_num IN VARCHAR2--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT IN VARCHAR2--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
													,L_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
													,l_err_MSG OUT varchar2--错误信息返回
                          );
		/*											
	PROCEDURE PO_RCV(P_FROM_CO_CODE IN VARCHAR2--生产的分厂
	                ,P_TO_CO_CODE IN VARCHAR2--采购接收的分厂
									,P_TYPE       IN VARCHAR2--类型：D:采购接收；R：采购退货；
									,P_PX_ID      IN NUMBER--瓶箱传入的唯一的id
									,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
									,P_LOT_ID     IN NUMBER
									,P_TRANS_DATE IN DATE--采购接收或退货事务时间
									,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
									,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
									,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
									,p_um         IN VARCHAR2--接收数量对应的单位
									,P_REMARK     IN VARCHAR2--备注
									,P_USER_NAME  IN VARCHAR2--用户名，可为空，空的时候默认：CY_ZCM
									,L_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,l_err_MSG OUT varchar2--错误信息返回
		);*/
                          
  PROCEDURE PX_PO_RCV(R_PO_RCV_IN IN CUX_DEVELOP_NS_PO_PKG.R_PO_RCV
                  ,V_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG OUT varchar2--错误信息返回
    );
		
	procedure CREATE_RCV_HEADER(P_CO_CODE        IN VARCHAR2,
		                          P_ORG_ID         in number,
                              P_PO_HEADER_ID   in number,
                              P_SHIP_HEADER_ID out number,
                              P_GROUP_ID       out number,
                              P_STATUS         out VARCHAR2
                              ,P_RECEIPT_NUM   OUT varchar2--D:采购接收事，返回接收号；
															);
	/*===================PX 成品采购接收&退货自动产生事务程序 END==================*/
	
	/*===================WMS PO 接口 START==================*/
--采购接收，接口程序 
procedure WMS_CREATE_PO_RCV(P_CO_CODE IN VARCHAR2,
                          P_PO_HEADER_ID IN number
                  ,P_PO_LINE_ID    IN NUMBER
                  ,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,P_LOT_NO     IN VARCHAR2
                  ,P_SUBLOT_NO     IN VARCHAR2
                  ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  ,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                  ,p_um         IN VARCHAR2--接收数量对应的单位
                  ,P_REMARK     IN VARCHAR2--备注
                  ,P_USER_ID  IN NUMBER--
                  ,p_vendor_lot_num IN VARCHAR2--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT IN VARCHAR2--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG OUT varchar2--错误信息返回
                  ,V_RECEIPT_NUM   OUT varchar2--D:采购接收事，返回接收号；R：采购退货，要求传入接收号；
                          );
													
--采购接收，采购退货，wms接口主程序                        
  PROCEDURE WMS_PO_RCV_INF(
                  P_TYPE       IN VARCHAR2--类型：D:采购接收；R：采购退货；
									,P_PO_HEADER_ID  IN NUMBER
									,P_PO_LINE_ID    IN NUMBER
                  ,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,P_LOT_NO     IN VARCHAR2
                  ,P_SUBLOT_NO     IN VARCHAR2
                  ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  ,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                  ,p_um         IN VARCHAR2--接收数量对应的单位
                  ,P_REMARK     IN VARCHAR2--备注
                  ,P_USER_NAME  IN VARCHAR2--用户名，可为空，空的时候默认：CY_ZCM
									,p_vendor_lot_num IN VARCHAR2--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
									,P_COMMENT IN VARCHAR2--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG OUT varchar2--错误信息返回
									,V_RECEIPT_NUM  IN OUT varchar2--D:采购接收事，返回接收号；R：采购退货，要求传入接收号；
    );
		
--采购订单信息写入WMS
procedure WMS_PO_ORDER(L_REQ_DATE IN DATE,
                    V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2);
										
--读取WMS结果，产生采购接收事务处理
procedure WMS_PO_RCV(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2);
										
--读取WMS结果，产生采购退货事务处理
procedure WMS_PO_RETURN(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2);
	
  /*===================WMS PO 接口 END==================*/
	
function GET_RETURN_QTY(P_item_ID in NUMBER,
		                                p_rcv_no IN VARCHAR2-- 长这样：TCL1-111
		) return NUMBER 
		;	
	
procedure UPDATE_WMS_IN_RET_QTY(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2);
										
										
end CUX_DEVELOP_NS_PO_PKG;
/
create or replace package body CUX_DEVELOP_NS_PO_PKG IS

 ERR_OTHERS exception;
  err_para EXCEPTION;
  err_no_data EXCEPTION;
	ERR_PARAMETER EXCEPTION;
  
   v_msg varchar2(4000);
   P_MSG varchar2(4000);
   p_trace        varchar2(240);
	 
	 ---------------启用时要更改 START-----------------------------------------
	 L_INI_REQ_DATE DATE:=SYSDATE-1/24;--按实际抽数间隔修改，抽数间隔变量
   L_CO_CODE        VARCHAR2(10) :='NS';
	 L_USER_NAME_WMS      VARCHAR2(10):='CY_DHQ';
	 P_USER_ID        number := 1648;--1618;--邓惠琴,1648;--CY_ZCM,这个默认用户需要有接收仓库的用户组织和仓管员权限--2187;--/*1618;--邓惠琴,--0;--*/2283;--LCJ;
	 P_USER_ID_SYS    NUMBER:=6043;
	 P_USER_ID_CP        number := 1648;--1648;--CY_ZCM,这个默认用户需要有接收仓库的用户组织和仓管员权限
	 ---------------启用时要更改 END-----------------------------------------
	
	 /*
  P_DATE           VARCHAR2(10) :='2015-5-5';
  P_TIME           VARCHAR2(10) :='12:10:00';
  
  
  P_RCV_TRANS_DATE date := TO_DATE(P_DATE, 'YYYY-MM-DD');--采购接收事务时间
  P_REL_DATE       date := TO_DATE(P_DATE, 'YYYY-MM-DD');--领料单发放事务时间，接收事务时间是发放时间+0.01
  P_PROD_PL_DATE       date := TO_DATE(P_DATE||' '||P_TIME,
                                   'YYYY-MM-DD HH24:MI:SS');--生产批配料消耗事务时间
  P_PROD_CP_DATE       date := TO_DATE(P_DATE||' '||P_TIME,
                                   'YYYY-MM-DD HH24:MI:SS');--生产批成品产出事务时间  
  P_BOTTLE_TRANS_DATE       date := TO_DATE(P_DATE||' '||P_TIME,
                                   'YYYY-MM-DD HH24:MI:SS');--瓶事务时间，不能大于当前系统时间
  P_RCV_LOT_NUM    varchar2(20) := REPLACE(P_DATE,'-','')||'-1';
  P_RCV_SUBLOT_NUM varchar2(20) := '0-M';
  P_RCV_LOCATION   varchar2(20) := 'LS-1';
  P_PO_REMARK      varchar2(20) := 'MD-'||REPLACE(P_DATE,'-','');
  P_REMARK      varchar2(20) := 'MD';
  P_CP_SUBLOT_NUM varchar2(20) := '0-0-M';
  
  --清酒损耗系数和校正系数每次运行前需和“陈彩珍”确认
  --L_QJXS             NUMBER:=1.0163;--1+清酒校正系数&报废系数&损耗
  L_QJ_SHXS            NUMBER:=0.0181;--清酒损耗系数
  L_QJ_JZXS_A          NUMBER:=1;--清酒A线校正系数
  L_QJ_JZXS_B          NUMBER:=1;--清酒B线校正系数
  L_QJ_JZXS_C          NUMBER:=0.9967;--清酒C线校正系数
  L_QJ_JZXS_D          NUMBER:=1.0008;--清酒D线校正系数
  L_QJ_JZXS_E          NUMBER:=0.9994;--清酒E线校正系数
  L_QJ_JZXS_F          NUMBER:=1;--清酒F线校正系数
  L_QJ_JZXS_G          NUMBER:=1;--清酒G线校正系数
  L_QJ_JZXS_H          NUMBER:=0.9973;--清酒H线校正系数
  L_QJ_JZXS_J          NUMBER:=0.9999;--清酒J线校正系数
  L_QJ_JZXS_M          NUMBER:=1;--清酒M线校正系数
  L_QJ_JZXS_S          NUMBER:=1;--清酒S线校正系数
  L_QJ_JZXS_Z          NUMBER:=1;--清酒Z线校正系数
  
  --旧瓶立即调整的仓库和货位
  P_bottle_WHSE_C      VARCHAR2(20):='PX62';--旧瓶创建仓库
  P_bottle_LOCATION_C  VARCHAR2(20):='CY-M';--旧瓶创建货位
  P_BOTTLE_REASON_CODE VARCHAR2(20):='A020';--旧瓶立即调整原因代码
  P_BOTTLE_REASON_CODE_T VARCHAR2(20):='A010';--旧瓶立即移动原因代码
  
	 */ 
	PROCEDURE MSG_OUTPUT(V_BUFF IN VARCHAR2) IS
		l_len NUMBER;
		l_star  NUMBER:=1;
		l_end   NUMBER:=127;--254;
  BEGIN
		l_len:=length(V_BUFF);
		IF l_len>127
			THEN
		WHILE l_star+l_end<l_len
			LOOP
   -- FND_FILE.PUT_LINE(FND_FILE.LOG, substr(v_BUFF,l_star,l_end));--写日志
    DBMS_OUTPUT.PUT_LINE(substr(v_BUFF,l_star,l_end));--调试输出
    --NULL;
		l_star:=l_star+127;--255;
		END LOOP;
		ELSE
		--	FND_FILE.PUT_LINE(FND_FILE.LOG, v_BUFF);--写日志
    DBMS_OUTPUT.PUT_LINE(V_BUFF);--调试输出
		END IF;
  END MSG_OUTPUT;
  
  /*===================PX 成品采购接收&退货自动产生事务程序 START==================*/
  /*###############################################################
  # NAME
  #  CREATE_PO_RCV
  # SYNOPSIS
  #  proc CREATE_PO_RCV
  # DESCRIPTION
  #  1、采购接收写接口表程序
  ###############################################################*/	
	--被替换			
  /*procedure CREATE_PO_RCV(P_CO_CODE VARCHAR2,
                          P_PO_HEADER_ID number) is
    L_LOT_ID         number;
    L_IFACE_RCV_REC  PO.RCV_TRANSACTIONS_INTERFACE%rowtype;
    L_IFACE_LOT      PO.RCV_LOTS_INTERFACE%rowtype;
		mtl_transaction_lots_interfac      mtl_transaction_lots_interface%rowtype;
    V_COUNT          number;
    L_OPM_ITEM_ID    number;
    L_CUR_MFG_ORG_ID number; --Current Inv Organization

    L_SHIP_HEADER_ID number;
    L_GROUP_ID       number;
    L_STATUS         varchar2(2);
    L_LOT_CTR        number;
    L_SUB_CTR        number;
    L_SHIPVEND_ID    number;
    L_DOC_DATE       date;
    L_QC_GRADE       varchar2(100);
    L_LOT_DESC       varchar2(100);

    cursor PO_HEAD is
      select distinct H.PO_HEADER_ID,
                      LL.SHIP_TO_ORGANIZATION_ID
        from PO_HEADERS_ALL        H,
             PO_LINES_ALL          L,
             PO_LINE_LOCATIONS_ALL LL
       where H.PO_HEADER_ID = L.PO_HEADER_ID
         and L.PO_LINE_ID = LL.PO_LINE_ID
         and H.PO_HEADER_ID = P_PO_HEADER_ID
         and H.TYPE_LOOKUP_CODE = 'STANDARD'
         and H.AUTHORIZATION_STATUS = 'APPROVED'
         and LL.QUANTITY > LL.QUANTITY_RECEIVED
				 ;

    cursor PO_LINE(L_PO_HEADER_ID number,L_SHIP_TO_ORGANIZATION_ID NUMBER) is
      select H.VENDOR_ID,
             H.VENDOR_SITE_ID,
             H.ORG_ID,
             H.CURRENCY_CODE,
             H.AGENT_ID,
             L.PO_LINE_ID,
             L.PO_HEADER_ID,
             LL.LINE_LOCATION_ID,
             D.PO_DISTRIBUTION_ID,
             L.UNIT_MEAS_LOOKUP_CODE,
             LL.SHIP_TO_LOCATION_ID,
             LL.SHIP_TO_ORGANIZATION_ID,
             L.ITEM_ID,
             B.PRIMARY_UNIT_OF_MEASURE,
             B.SECONDARY_UOM_CODE,

             L.ITEM_DESCRIPTION,
             L.CATEGORY_ID,
             --L.QUANTITY QUANTITY,
						 LL.QUANTITY - LL.QUANTITY_RECEIVED QUANTITY,
             L.UNIT_PRICE,
             LL.NEED_BY_DATE
        from PO_HEADERS_ALL        H,
             PO_LINES_ALL          L,
             PO_LINE_LOCATIONS_ALL LL,
             PO_DISTRIBUTIONS_ALL  D,
             MTL_SYSTEM_ITEMS_B    B
       where H.PO_HEADER_ID = L.PO_HEADER_ID
         and L.PO_LINE_ID = LL.PO_LINE_ID
         and L.PO_LINE_ID = D.PO_LINE_ID
         and L.PO_HEADER_ID = D.PO_HEADER_ID
         and L.ITEM_ID = B.INVENTORY_ITEM_ID
         and LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
         and LL.QUANTITY > LL.QUANTITY_RECEIVED
         and H.PO_HEADER_ID = L_PO_HEADER_ID
         AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
         ;
    CR_PO_HEAD PO_HEAD%rowtype;
    CR_PO_LINE PO_LINE%rowtype;
		
		L_RECEIPT_NUM NUMBER;
  begin
    for CR_PO_HEAD in PO_HEAD
    loop
      CREATE_RCV_HEADER(P_CO_CODE,
                        P_ORG_ID         => CR_PO_HEAD.SHIP_TO_ORGANIZATION_ID,
                        P_PO_HEADER_ID   => CR_PO_HEAD.PO_HEADER_ID,
                        P_SHIP_HEADER_ID => L_SHIP_HEADER_ID, --out
                        P_GROUP_ID       => L_GROUP_ID, --out
                        P_STATUS         => L_STATUS --out
												,P_RECEIPT_NUM    => L_RECEIPT_NUM
                        );
      if L_STATUS not in ('S', 'W')
      then
        MSG_OUTPUT('PO_HEADER_ID' || ':' ||
                             CR_PO_LINE.PO_HEADER_ID || ',' ||
                             '创建采购入库头表出错.');
        raise ERR_OTHERS;
      end if;

      for CR_PO_LINE in PO_LINE(CR_PO_HEAD.PO_HEADER_ID,CR_PO_HEAD.SHIP_TO_ORGANIZATION_ID)
      loop

        select B.ITEM_ID,
               B.LOT_CTL,
               B.SUBLOT_CTL
          into L_OPM_ITEM_ID,
               L_LOT_CTR,
               L_SUB_CTR
          from IC_ITEM_MST_B B
         where B.ITEM_NO =
               (select M.SEGMENT1
                  from MTL_SYSTEM_ITEMS_B M
                 where M.INVENTORY_ITEM_ID = CR_PO_LINE.ITEM_ID
                   and M.ORGANIZATION_ID =
                       CR_PO_LINE.SHIP_TO_ORGANIZATION_ID);

        L_CUR_MFG_ORG_ID := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;

        L_IFACE_RCV_REC.TRANSACTION_DATE := P_RCV_TRANS_DATE;

        select RCV_TRANSACTIONS_INTERFACE_S.nextval
          into L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID
          from DUAL;

        L_IFACE_RCV_REC.GROUP_ID := L_GROUP_ID;

        L_IFACE_RCV_REC.INTERFACE_SOURCE_CODE   := 'NS TO GF CPRK';--'RCV';
        L_IFACE_RCV_REC.SOURCE_DOCUMENT_CODE    := 'PO';
        L_IFACE_RCV_REC.PROCESSING_STATUS_CODE  := 'PENDING';
        L_IFACE_RCV_REC.TRANSACTION_STATUS_CODE := 'PENDING';
        L_IFACE_RCV_REC.INSPECTION_STATUS_CODE  := 'NOT INSPECTED';
        L_IFACE_RCV_REC.DESTINATION_CONTEXT     := 'INVENTORY';
        L_IFACE_RCV_REC.DESTINATION_TYPE_CODE   := 'INVENTORY';
        L_IFACE_RCV_REC.AUTO_TRANSACT_CODE      := 'DELIVER';
        L_IFACE_RCV_REC.PROCESSING_MODE_CODE    := 'BATCH';--'ONLINE';--'IMMEDIATE';--其他两个类型没测试通，提交请求没反应
        L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE     := 'VENDOR';
        L_IFACE_RCV_REC.TRANSACTION_TYPE        := 'RECEIVE';

        L_IFACE_RCV_REC.CURRENCY_CODE := 'RMB';

        L_IFACE_RCV_REC.SHIP_TO_LOCATION_ID := CR_PO_LINE.SHIP_TO_LOCATION_ID;

        begin
          select V.SECONDARY_INVENTORY_NAME
            into L_IFACE_RCV_REC.SUBINVENTORY
            from MTL_SECONDARY_INVENTORIES_FK_V V
           where V.ORGANIZATION_ID = CR_PO_LINE.SHIP_TO_ORGANIZATION_ID
             and ROWNUM = 1;
        exception
          when others then
            MSG_OUTPUT(CR_PO_LINE.SHIP_TO_ORGANIZATION_ID || ',' ||
                                 '找不到子库存.');
            raise ERR_OTHERS;
        end;
        begin
          select S.INVENTORY_LOCATION_ID
            into L_IFACE_RCV_REC.LOCATOR_ID
            from MTL_ITEM_LOCATIONS S
           where S.ORGANIZATION_ID = CR_PO_LINE.SHIP_TO_ORGANIZATION_ID
             and S.SEGMENT1 ='02-01-01'-- 'C1-03-01'--P_RCV_LOCATION
						 ;
        exception
          when others then
            MSG_OUTPUT(L_IFACE_RCV_REC.SUBINVENTORY || ',' ||'找不到货位 .');
            raise ERR_OTHERS;
        end;

        L_IFACE_RCV_REC.TO_ORGANIZATION_ID         := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;
        L_IFACE_RCV_REC.VENDOR_ID                  := CR_PO_LINE.VENDOR_ID;
        L_IFACE_RCV_REC.VENDOR_SITE_ID             := CR_PO_LINE.VENDOR_SITE_ID;
        L_IFACE_RCV_REC.ITEM_ID                    := CR_PO_LINE.ITEM_ID;
        L_IFACE_RCV_REC.ITEM_DESCRIPTION           := CR_PO_LINE.ITEM_DESCRIPTION;
        L_IFACE_RCV_REC.CATEGORY_ID                := CR_PO_LINE.CATEGORY_ID;
        L_IFACE_RCV_REC.SOURCE_DOC_UNIT_OF_MEASURE := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.UNIT_OF_MEASURE            := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.UOM_CODE                   := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.QUANTITY                   := CR_PO_LINE.QUANTITY;
        L_IFACE_RCV_REC.PO_UNIT_PRICE              := CR_PO_LINE.UNIT_PRICE;
        L_IFACE_RCV_REC.SECONDARY_QUANTITY         := GMICUOM.UOM_CONVERSION(L_OPM_ITEM_ID,
                                                                             0,
                                                                             CR_PO_LINE.QUANTITY,
                                                                             CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                             CR_PO_LINE.SECONDARY_UOM_CODE,
                                                                             0);

        L_IFACE_RCV_REC.SECONDARY_UNIT_OF_MEASURE := CR_PO_LINE.SECONDARY_UOM_CODE;
        L_IFACE_RCV_REC.SECONDARY_UOM_CODE        := CR_PO_LINE.SECONDARY_UOM_CODE;
        L_IFACE_RCV_REC.PRIMARY_UNIT_OF_MEASURE   := CR_PO_LINE.PRIMARY_UNIT_OF_MEASURE;
        L_IFACE_RCV_REC.PRIMARY_QUANTITY          := GMICUOM.UOM_CONVERSION(L_OPM_ITEM_ID,
                                                                            0,
                                                                            CR_PO_LINE.QUANTITY,
                                                                            CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                            CR_PO_LINE.PRIMARY_UNIT_OF_MEASURE,
                                                                            0);

        L_IFACE_RCV_REC.SOURCE_DOC_QUANTITY := CR_PO_LINE.QUANTITY;
        L_IFACE_RCV_REC.PO_HEADER_ID        := CR_PO_LINE.PO_HEADER_ID;
        L_IFACE_RCV_REC.ROUTING_HEADER_ID   := 3;
        L_IFACE_RCV_REC.PO_LINE_ID          := CR_PO_LINE.PO_LINE_ID;
        L_IFACE_RCV_REC.SHIPMENT_HEADER_ID  := L_SHIP_HEADER_ID; -----------
        L_IFACE_RCV_REC.PO_DISTRIBUTION_ID  := CR_PO_LINE.PO_DISTRIBUTION_ID;
        L_IFACE_RCV_REC.PO_LINE_LOCATION_ID := CR_PO_LINE.LINE_LOCATION_ID;

        L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE := CR_PO_LINE.NEED_BY_DATE;

        L_IFACE_RCV_REC.USE_MTL_LOT := 2;--2：启用批次控制；1：不启用批次控制
        L_IFACE_RCV_REC.EMPLOYEE_ID := CR_PO_LINE.AGENT_ID;

        L_IFACE_RCV_REC.USE_MTL_SERIAL := 1;--2：启用序列；1：不启用序列；

        L_IFACE_RCV_REC.ROUTING_STEP_ID := 1;

        L_IFACE_RCV_REC.LAST_UPDATE_LOGIN := P_USER_ID;
        L_IFACE_RCV_REC.LAST_UPDATED_BY   := P_USER_ID;
        L_IFACE_RCV_REC.CREATED_BY        := P_USER_ID;
        L_IFACE_RCV_REC.CREATION_DATE     := sysdate;
        L_IFACE_RCV_REC.LAST_UPDATE_DATE  := sysdate;
        insert into PO.RCV_TRANSACTIONS_INTERFACE
          (INTERFACE_TRANSACTION_ID,
           ITEM_DESCRIPTION,
           RECEIPT_SOURCE_CODE,
           SOURCE_DOC_UNIT_OF_MEASURE,
           UNIT_OF_MEASURE,
           PRIMARY_UNIT_OF_MEASURE,
           UOM_CODE,
           CURRENCY_CODE,
           TRANSACTION_TYPE,
           INTERFACE_SOURCE_CODE,
           SOURCE_DOCUMENT_CODE,
           PROCESSING_STATUS_CODE,
           TRANSACTION_STATUS_CODE,
           INSPECTION_STATUS_CODE,
           DESTINATION_CONTEXT,
           DESTINATION_TYPE_CODE,
           AUTO_TRANSACT_CODE,
           SUBINVENTORY,
           PROCESSING_MODE_CODE,
           TO_ORGANIZATION_ID,
           PO_HEADER_ID,
           GROUP_ID,
           VENDOR_ID,
           VENDOR_SITE_ID,
           ITEM_ID,
           ROUTING_HEADER_ID,
           SHIPMENT_HEADER_ID,
           LAST_UPDATE_LOGIN,
           LAST_UPDATED_BY,
           CREATED_BY,
           PO_LINE_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           EXPECTED_RECEIPT_DATE,
           TRANSACTION_DATE,
           USE_MTL_LOT,
           EMPLOYEE_ID,
           PO_DISTRIBUTION_ID,
           PO_LINE_LOCATION_ID,
           SHIP_TO_LOCATION_ID,
           CATEGORY_ID,
           LOCATOR_ID,
           USE_MTL_SERIAL,
           SOURCE_DOC_QUANTITY,
           PO_UNIT_PRICE,
           ROUTING_STEP_ID,
           PRIMARY_QUANTITY,
           QUANTITY,
           SECONDARY_QUANTITY,
           SECONDARY_UNIT_OF_MEASURE)
        values
          (L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID,
           L_IFACE_RCV_REC.ITEM_DESCRIPTION,
           L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE,
           L_IFACE_RCV_REC.SOURCE_DOC_UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.PRIMARY_UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.UOM_CODE,
           L_IFACE_RCV_REC.CURRENCY_CODE,
           L_IFACE_RCV_REC.TRANSACTION_TYPE,
           L_IFACE_RCV_REC.INTERFACE_SOURCE_CODE,
           L_IFACE_RCV_REC.SOURCE_DOCUMENT_CODE,
           L_IFACE_RCV_REC.PROCESSING_STATUS_CODE,
           L_IFACE_RCV_REC.TRANSACTION_STATUS_CODE,
           L_IFACE_RCV_REC.INSPECTION_STATUS_CODE,
           L_IFACE_RCV_REC.DESTINATION_CONTEXT,
           L_IFACE_RCV_REC.DESTINATION_TYPE_CODE,
           L_IFACE_RCV_REC.AUTO_TRANSACT_CODE,
           L_IFACE_RCV_REC.SUBINVENTORY,
           L_IFACE_RCV_REC.PROCESSING_MODE_CODE,
           L_IFACE_RCV_REC.TO_ORGANIZATION_ID,
           L_IFACE_RCV_REC.PO_HEADER_ID,
           L_IFACE_RCV_REC.GROUP_ID,
           L_IFACE_RCV_REC.VENDOR_ID,
           L_IFACE_RCV_REC.VENDOR_SITE_ID,
           L_IFACE_RCV_REC.ITEM_ID,
           L_IFACE_RCV_REC.ROUTING_HEADER_ID,
           L_IFACE_RCV_REC.SHIPMENT_HEADER_ID,
           L_IFACE_RCV_REC.LAST_UPDATE_LOGIN,
           L_IFACE_RCV_REC.LAST_UPDATED_BY,
           L_IFACE_RCV_REC.CREATED_BY,
           L_IFACE_RCV_REC.PO_LINE_ID,
           L_IFACE_RCV_REC.CREATION_DATE,
           L_IFACE_RCV_REC.LAST_UPDATE_DATE,
           L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE,
           L_IFACE_RCV_REC.TRANSACTION_DATE,
           L_IFACE_RCV_REC.USE_MTL_LOT,
           L_IFACE_RCV_REC.EMPLOYEE_ID,
           L_IFACE_RCV_REC.PO_DISTRIBUTION_ID,
           L_IFACE_RCV_REC.PO_LINE_LOCATION_ID,
           L_IFACE_RCV_REC.SHIP_TO_LOCATION_ID,
           L_IFACE_RCV_REC.CATEGORY_ID,
           L_IFACE_RCV_REC.LOCATOR_ID,
           L_IFACE_RCV_REC.USE_MTL_SERIAL,
           L_IFACE_RCV_REC.SOURCE_DOC_QUANTITY,
           L_IFACE_RCV_REC.PO_UNIT_PRICE,
           L_IFACE_RCV_REC.ROUTING_STEP_ID,
           L_IFACE_RCV_REC.PRIMARY_QUANTITY,
           L_IFACE_RCV_REC.QUANTITY,
           L_IFACE_RCV_REC.SECONDARY_QUANTITY,
           L_IFACE_RCV_REC.SECONDARY_UNIT_OF_MEASURE);

        if L_LOT_CTR + L_SUB_CTR = 0
        then
          null;
        else
          L_IFACE_LOT.LAST_UPDATE_DATE  := sysdate;
          L_IFACE_LOT.LAST_UPDATED_BY   := P_USER_ID;
          L_IFACE_LOT.CREATION_DATE     := sysdate;
          L_IFACE_LOT.CREATED_BY        := P_USER_ID;
          L_IFACE_LOT.LAST_UPDATE_LOGIN := -1;

          L_IFACE_LOT.INTERFACE_TRANSACTION_ID := L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID;
          L_IFACE_LOT.QUANTITY                 := L_IFACE_RCV_REC.QUANTITY;
          L_IFACE_LOT.PRIMARY_QUANTITY         := L_IFACE_RCV_REC.PRIMARY_QUANTITY;
          L_IFACE_LOT.ITEM_ID                  := L_IFACE_RCV_REC.ITEM_ID;
          L_IFACE_LOT.TRANSACTION_DATE         := L_IFACE_RCV_REC.TRANSACTION_DATE;
          L_IFACE_LOT.EXPIRATION_DATE          := L_IFACE_RCV_REC.TRANSACTION_DATE + 365;
          L_IFACE_LOT.SECONDARY_QUANTITY       := L_IFACE_RCV_REC.SECONDARY_QUANTITY;
          L_IFACE_LOT.LOT_NUM                  := P_RCV_LOT_NUM;
          if L_SUB_CTR = 1
          then
            L_IFACE_LOT.SUBLOT_NUM := P_RCV_SUBLOT_NUM;
          else
            L_IFACE_LOT.SUBLOT_NUM := null;
          end if;

          select count(*)
            into V_COUNT
            from IC_LOTS_MST T
           where T.LOT_NO = L_IFACE_LOT.LOT_NUM
             and T.ITEM_ID = L_OPM_ITEM_ID
             and NVL(T.SUBLOT_NO,
                     1) = NVL(L_IFACE_LOT.SUBLOT_NUM,
                              1);
          if V_COUNT = 0
          then
            L_LOT_ID := CUX_DEVELOP_LCJ_PKG.IC_LOT_CREATE(V_ITEM_ID          => L_OPM_ITEM_ID,
                                                          V_LOT_NO           => L_IFACE_LOT.LOT_NUM,
                                                          V_SUBLOT_NO        => L_IFACE_LOT.SUBLOT_NUM,
                                                          V_ORIGINATION_TYPE => 2,
                                                          V_SHIPVEND_ID      => L_SHIPVEND_ID,
                                                          V_VENDOR_LOT_NO    => null,
                                                          V_RECV_DATE        => L_DOC_DATE,
                                                          V_QC_GRADE         => L_QC_GRADE,
                                                          V_LOT_DESC         => L_LOT_DESC,
                                                          V_COMMIT           => 'F'--'T'
																													);
          end if;

          insert into RCV_LOTS_INTERFACE
            (LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             CREATION_DATE,
             CREATED_BY,
             LAST_UPDATE_LOGIN,
             INTERFACE_TRANSACTION_ID,
             QUANTITY,
             PRIMARY_QUANTITY,
             ITEM_ID,
             TRANSACTION_DATE,
             LOT_NUM,
             SUBLOT_NUM,
             EXPIRATION_DATE,
             SECONDARY_QUANTITY)
          values
            (L_IFACE_LOT.LAST_UPDATE_DATE,
             L_IFACE_LOT.LAST_UPDATED_BY,
             L_IFACE_LOT.CREATION_DATE,
             L_IFACE_LOT.CREATED_BY,
             L_IFACE_LOT.LAST_UPDATE_LOGIN,
             L_IFACE_LOT.INTERFACE_TRANSACTION_ID,
             L_IFACE_LOT.QUANTITY,
             L_IFACE_LOT.PRIMARY_QUANTITY,
             L_IFACE_LOT.ITEM_ID,
             L_IFACE_LOT.TRANSACTION_DATE,
             L_IFACE_LOT.LOT_NUM,
             L_IFACE_LOT.SUBLOT_NUM,
             L_IFACE_LOT.EXPIRATION_DATE,
             L_IFACE_LOT.SECONDARY_QUANTITY);
										
					mtl_transaction_lots_interfac.last_update_date       := SYSDATE;  
          mtl_transaction_lots_interfac.last_updated_by        := P_USER_ID;--fnd_global.user_id;  
          mtl_transaction_lots_interfac.creation_date          := SYSDATE;  
          mtl_transaction_lots_interfac.created_by             := P_USER_ID;--fnd_global.user_id;  
          mtl_transaction_lots_interfac.last_update_login      := -1;  
          mtl_transaction_lots_interfac.product_code           := 'RCV';  
          mtl_transaction_lots_interfac.product_transaction_id :=  L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID;--rcv_transactions_interface.interface_transaction_id;  
          mtl_transaction_lots_interfac.lot_number             := P_RCV_LOT_NUM;--rec_line.lot_number;  
					
					mtl_transaction_lots_interfac.sublot_num             :=  L_IFACE_LOT.SUBLOT_NUM;
          mtl_transaction_lots_interfac.transaction_quantity   := L_IFACE_RCV_REC.QUANTITY;--l_iface_rcv_rec.quantity;  
          mtl_transaction_lots_interfac.primary_quantity       := L_IFACE_RCV_REC.PRIMARY_QUANTITY;--l_primary_qty;  
          
          SELECT mtl_material_transactions_s.NEXTVAL  
          INTO   mtl_transaction_lots_interfac.transaction_interface_id  
          FROM   dual;  
          
         -- l_primary_qty :=1;  
          
          INSERT INTO mtl_transaction_lots_interface VALUES mtl_transaction_lots_interfac;  
					 
        end if;
      end loop;
    end loop;
    commit;

  end;*/
	
	 /*###############################################################
  # NAME
  #  CREATE_PO_RETURN
  # SYNOPSIS
  #  proc CREATE_PO_RETURN
  # DESCRIPTION
  #  1、采购退货写接口表程序
  ###############################################################*/       
  procedure CREATE_PO_RETURN(P_WHSE_CODE IN VARCHAR2
                          ,P_RCV_NO IN VARCHAR2
                          ,P_ITEM_ID IN  NUMBER
                          ,P_LOT_ID  IN  NUMBER
                          ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                          ,P_WHSE_CODE_ON  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                          ,p_um         IN VARCHAR2--接收数量对应的单位
                          ,P_REMARK     IN VARCHAR2--备注
                  ,p_vendor_lot_num IN VARCHAR2--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT IN VARCHAR2--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                          ,L_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                          ,l_err_MSG OUT varchar2--错误信息返回                          
                          ) is
    L_LOT_ID         number;
    L_IFACE_RCV_REC  PO.RCV_TRANSACTIONS_INTERFACE%rowtype;
    L_IFACE_LOT      PO.RCV_LOTS_INTERFACE%rowtype;
    mtl_transaction_lots_interfac      mtl_transaction_lots_interface%rowtype;
    V_COUNT          number;
    L_OPM_ITEM_ID    number;
    L_CUR_MFG_ORG_ID number; --Current Inv Organization

    L_SHIP_HEADER_ID number;
    L_GROUP_ID       number;
    L_STATUS         varchar2(2);
    L_LOT_CTR        number;
    L_SUB_CTR        number;
    L_SHIPVEND_ID    number;
    L_DOC_DATE       date;
    L_QC_GRADE       varchar2(100);
    L_LOT_DESC       varchar2(100);
		
		L_TRANS                    VARCHAR2(1000);
		L_MSG                      VARCHAR2(4000);
		L_QTY                      NUMBER;
		
		
    L_REQUEST_ID  number;
    V_STATUS_CODE varchar2(1);
    V_PHASE_CODE  varchar2(1);
    V_PHASE       varchar2(100);
    V_STATUS      varchar2(100);
    V_DEV_PHASE   varchar2(100);
    V_DEV_STATUS  varchar2(100);
    V_MESSAGE     varchar2(400);
    L_RESP_ID   NUMBER;
		L_COUNT     NUMBER:=0;

    cursor PO_LINE(L_WHSE_CODE VARCHAR2,L_RCV_NO VARCHAR2,L_ITEM_ID NUMBER,L_LOT_ID NUMBER) is
      SELECT rt.currency_conversion_rate,
RT.SHIPMENT_HEADER_ID,
RT.SHIPMENT_LINE_ID,
RT.PARENT_TRANSACTION_ID,
PHA.VENDOR_ID,
             PHA.VENDOR_SITE_ID,
             PHA.ORG_ID,
             PHA.CURRENCY_CODE,
             PHA.AGENT_ID,
             PLA.PO_LINE_ID,
             PLA.PO_HEADER_ID,
             LL.LINE_LOCATION_ID,
             D.PO_DISTRIBUTION_ID,
             PLA.UNIT_MEAS_LOOKUP_CODE,
             LL.SHIP_TO_LOCATION_ID,
             LL.SHIP_TO_ORGANIZATION_ID,
             PLA.ITEM_ID,
             B.PRIMARY_UNIT_OF_MEASURE,
             B.SECONDARY_UOM_CODE,

             PLA.ITEM_DESCRIPTION,
             PLA.CATEGORY_ID,
            -- L.QUANTITY QUANTITY,
             ll.quantity_received QUANTITY,
            -- LL.QUANTITY - LL.QUANTITY_RECEIVED QUANTITY,
            SUM(P.TRANS_QTY) TRANS_QTY,
            SUM(P.TRANS_QTY2) TRANS_QTY2,
            P.TRANS_UM,
            P.TRANS_UM2,
             PLA.UNIT_PRICE,
             LL.NEED_BY_DATE
             ,
             L.LOT_NO,
 L.SUBLOT_NO
 ,P.WHSE_CODE
 ,P.LOCATION
            /* ,LT.PRIMARY_QUANTITY,
             LT.QUANTITY,
             LT.SECONDARY_QUANTITY,
             LT.SUBLOT_NUM,
             LT.LOT_NUM,*/
   
  FROM PO_HEADERS_ALL       PHA,
       RCV_TRANSACTIONS     RT,
       PO_VENDORS           PV,
       PO_LINES_ALL         PLA,
       RCV_SHIPMENT_HEADERS RSH,
       IC_TRAN_PND          P,
       IC_LOTS_MST          L,
      -- PO_HEADERS_RFQQT_V   BJH,

             PO_LINE_LOCATIONS_ALL LL,
             PO_DISTRIBUTIONS_ALL  D,
             MTL_SYSTEM_ITEMS_B    B
          --   ,RCV_LOT_TRANSACTIONS LT
 WHERE RT.PO_LINE_ID = PLA.PO_LINE_ID
   --AND PLA.FROM_HEADER_ID = BJH.PO_HEADER_ID(+)
   AND P.ITEM_ID = L.ITEM_ID
   AND P.LOT_ID = L.LOT_ID
   AND RT.SHIPMENT_HEADER_ID = RSH.SHIPMENT_HEADER_ID
   AND PLA.PO_HEADER_ID = PHA.PO_HEADER_ID
   AND PHA.VENDOR_ID = PV.VENDOR_ID
   AND RT.TRANSACTION_TYPE IN ('DELIVER',
                               'CORRECT', /* 'RETURN TO RECEIVING',*/
                               'RETURN TO VENDOR')
      
   --AND TO_CHAR(RT.TRANSACTION_DATE, 'YYYYMM') LIKE &YYYYMM --'%2010%' --= '05-2010' 
      /* AND PLA.ORG_ID = \*:p_org_id  --*\
      '123'*/
   AND RT.SHIPMENT_HEADER_ID = P.DOC_ID
   AND P.LINE_ID = RT.TRANSACTION_ID
   AND P.DOC_TYPE = 'PORC'
   AND P.DELETE_MARK = 0
   AND P.COMPLETED_IND = 1
   
   /*   
   AND PHA.SEGMENT1 LIKE &PO_NUMBER --'5042'
   AND RSH.RECEIPT_NUM LIKE &RCV_NUMBER
   AND (SELECT MSI.SEGMENT1
          FROM MTL_SYSTEM_ITEMS_B MSI
         WHERE MSI.INVENTORY_ITEM_ID = PLA.ITEM_ID
           AND ROWNUM = 1) LIKE &ITEM_NO
      
   AND P.CO_CODE LIKE &CO_CODE
   AND P.WHSE_CODE LIKE &WHSE_CODE
   */
   and pLa.PO_LINE_ID = LL.PO_LINE_ID
         and pLa.PO_LINE_ID = D.PO_LINE_ID
         and pLa.PO_HEADER_ID = D.PO_HEADER_ID
         and pLa.ITEM_ID = B.INVENTORY_ITEM_ID
         and LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
        
   
   --AND RT.transaction_id = LT.SOURCE_TRANSACTION_ID(+)
        --AND ll.quantity_received>0
        
        AND RSH.RECEIPT_NUM =L_RCV_NO--71567
        AND p.whse_code=L_WHSE_CODE--'PX21'
				AND P.ITEM_ID=L_ITEM_ID
				AND P.LOT_ID=L_LOT_ID
        
        GROUP BY RT.SHIPMENT_HEADER_ID,
RT.SHIPMENT_LINE_ID,
RT.PARENT_TRANSACTION_ID,
PHA.VENDOR_ID,
             PHA.VENDOR_SITE_ID,
             PHA.ORG_ID,
             PHA.CURRENCY_CODE,
             PHA.AGENT_ID,
             PLA.PO_LINE_ID,
             PLA.PO_HEADER_ID,
             LL.LINE_LOCATION_ID,
             D.PO_DISTRIBUTION_ID,
             PLA.UNIT_MEAS_LOOKUP_CODE,
             LL.SHIP_TO_LOCATION_ID,
             LL.SHIP_TO_ORGANIZATION_ID,
             PLA.ITEM_ID,
             B.PRIMARY_UNIT_OF_MEASURE,
             B.SECONDARY_UOM_CODE,

             PLA.ITEM_DESCRIPTION,
             PLA.CATEGORY_ID,
            -- L.QUANTITY QUANTITY,
             ll.quantity_received ,
            -- LL.QUANTITY - LL.QUANTITY_RECEIVED QUANTITY,
            --SUM(P.TRANS_QTY) TRANS_QTY,
            --SUM(P.TRANS_QTY2) TRANS_QTY2,
            P.TRANS_UM,
            P.TRANS_UM2,
             PLA.UNIT_PRICE,
             LL.NEED_BY_DATE
             ,
             L.LOT_NO,
 L.SUBLOT_NO
 ,P.WHSE_CODE
 ,P.LOCATION
 ,rt.currency_conversion_rate
   ;
         
    --CR_PO_HEAD PO_HEAD%rowtype;
    CR_PO_LINE PO_LINE%rowtype;
  BEGIN
		 select PO.RCV_INTERFACE_GROUPS_S.nextval
      into L_GROUP_ID
      from DUAL;
   
	    L_COUNT:=0;
			
      for CR_PO_LINE in PO_LINE(P_WHSE_CODE,P_RCV_NO,P_ITEM_ID,P_LOT_ID)
      LOOP
				
			L_COUNT :=L_COUNT+1;
			
				BEGIN
					L_TRANS:='采购退货数量 检查';
					IF CR_PO_LINE.TRANS_QTY <1 OR CR_PO_LINE.TRANS_QTY < P_QTY
						THEN
							L_MSG:=L_MSG||' 采购退货数量：P_QTY：'||P_QTY||',大于可退货数量：CR_PO_LINE.TRANS_QTY:'||CR_PO_LINE.TRANS_QTY||'； ';
							RAISE err_others;
					END IF;
			    
					exception
						when others THEN
							L_MSG:=L_MSG||' 采购退货数量 检查';
						RAISE err_others;
					END;
		
        BEGIN
          L_TRANS:='接收仓库货位 检查';
          IF CR_PO_LINE.WHSE_CODE <>P_WHSE_CODE_ON OR CR_PO_LINE.LOCATION <>P_LOCATION
            THEN
              L_MSG:=L_MSG||' 要退货的仓库：P_WHSE_CODE_ON：'||P_WHSE_CODE_ON||',退货货位：P_LOCATION:'||P_LOCATION||' ,与接收仓库：CR_PO_LINE.WHSE_CODE'||CR_PO_LINE.WHSE_CODE||',接收货位：CR_PO_LINE.LOCATION：'||CR_PO_LINE.LOCATION||',不一致； ';
              RAISE err_others;
          END IF;
          
          exception
            when others THEN
              L_MSG:=L_MSG||' 接收仓库货位 检查';
            RAISE err_others;
          END;
  /*  
        BEGIN
          L_TRANS:='退货仓库货位现有量 检查';
					SELECT P.LOCT_ONHAND
					INTO L_QTY
					FROM IC_ITEM_MST_B I, IC_LOCT_INV P, IC_LOTS_MST L
				 WHERE P.ITEM_ID = I.ITEM_ID
					 AND P.ITEM_ID = L.ITEM_ID
					 AND P.LOT_ID = L.LOT_ID
					 --AND P.LOCT_ONHAND <>0  
					AND P.ITEM_ID=P_ITEM_ID
							and p.lot_id =P_LOT_ID
						AND P.LOCATION =P_LOCATION
					 AND P.WHSE_CODE =P_WHSE_CODE_ON
				;

          IF L_QTY<P_QTY
            THEN
              L_MSG:=L_MSG||' 要退货的仓库：P_WHSE_CODE_ON：'||P_WHSE_CODE_ON||',退货货位：P_LOCATION:'||P_LOCATION||' ,现有量不够要求退货的数量：P_QTY'||P_QTY||'； ';
              RAISE err_others;
          END IF;
          
          exception
            when others THEN
              L_MSG:=L_MSG||' 退货仓库货位现有量 检查';
            RAISE err_others;
          END;
    */--cancle for jsj_jlz 2015-7-23 
		
	/*--追加格式
		BEGIN
		L_TRANS:='XXXX 检查';
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =P_TO_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||',P_WHSE_CODE:'||P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：XXXX 检查';
      RAISE err_others;
    END;
		*/      
        select B.ITEM_ID,
               B.LOT_CTL,
               B.SUBLOT_CTL
          into L_OPM_ITEM_ID,
               L_LOT_CTR,
               L_SUB_CTR
          from IC_ITEM_MST_B B
         where B.ITEM_NO =
               (select M.SEGMENT1
                  from MTL_SYSTEM_ITEMS_B M
                 where M.INVENTORY_ITEM_ID = CR_PO_LINE.ITEM_ID
                   and M.ORGANIZATION_ID =
                       CR_PO_LINE.SHIP_TO_ORGANIZATION_ID);

        L_CUR_MFG_ORG_ID := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;

        L_IFACE_RCV_REC.TRANSACTION_DATE := P_TRANS_DATE;

        select RCV_TRANSACTIONS_INTERFACE_S.nextval
          into L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID
          from DUAL;

        L_IFACE_RCV_REC.GROUP_ID := L_GROUP_ID;

        L_IFACE_RCV_REC.INTERFACE_SOURCE_CODE   := P_REMARK;--'NS TO GF CPTK';--null
        --L_IFACE_RCV_REC.Vendor_Lot_Num   :=p_vendor_lot_num;--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
				
				----add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息 START--
				BEGIN
				SELECT L.VENDOR_LOT_NO
				INTO L_IFACE_RCV_REC.Vendor_Lot_Num 
				FROM ic_lots_mst l
				WHERE l.item_id=P_ITEM_ID
				AND l.lot_id=P_LOT_ID
				AND ROWNUM=1
				;
				EXCEPTION
					WHEN OTHERS THEN
						L_IFACE_RCV_REC.Vendor_Lot_Num   :=p_vendor_lot_num;
				END;
				----add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息 END --
				
        L_IFACE_RCV_REC.Comments   :=P_COMMENT;--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
        
				L_IFACE_RCV_REC.CREATE_DEBIT_MEMO_FLAG  :='N';
        L_IFACE_RCV_REC.SOURCE_DOCUMENT_CODE    := 'PO';
        L_IFACE_RCV_REC.PROCESSING_STATUS_CODE  := 'PENDING';
        L_IFACE_RCV_REC.TRANSACTION_STATUS_CODE := 'PENDING';
        L_IFACE_RCV_REC.INSPECTION_STATUS_CODE  := 'NOT INSPECTED';
				
  --l_iface_rcv_rec.po_release_id        := NULL;

        L_IFACE_RCV_REC.DESTINATION_CONTEXT     := /*'RECEIVING';--*/'INVENTORY';
        L_IFACE_RCV_REC.DESTINATION_TYPE_CODE   := /*'RECEIVING';--*/'INVENTORY';
        L_IFACE_RCV_REC.AUTO_TRANSACT_CODE      := NULL;--'DELIVER';
        L_IFACE_RCV_REC.PROCESSING_MODE_CODE    := 'BATCH';--'ONLINE';--'IMMEDIATE';--其他两个类型没测试通，提交请求没反应
        L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE     := 'VENDOR';
        L_IFACE_RCV_REC.TRANSACTION_TYPE        := 'RETURN TO VENDOR';--'RECEIVE';

        L_IFACE_RCV_REC.CURRENCY_CODE := 'RMB';

        L_IFACE_RCV_REC.SHIP_TO_LOCATION_ID :=NULL;-- CR_PO_LINE.SHIP_TO_LOCATION_ID;

        begin
          select V.SECONDARY_INVENTORY_NAME
            into L_IFACE_RCV_REC.FROM_SUBINVENTORY
            from MTL_SECONDARY_INVENTORIES_FK_V V
           where V.ORGANIZATION_ID = CR_PO_LINE.SHIP_TO_ORGANIZATION_ID
             and ROWNUM = 1;
        exception
          when others then
            MSG_OUTPUT(CR_PO_LINE.SHIP_TO_ORGANIZATION_ID || ',' ||
                                 '找不到子库存.');
            raise ERR_OTHERS;
        end;
        begin
          select S.INVENTORY_LOCATION_ID
            into L_IFACE_RCV_REC.FROM_LOCATOR_ID
            from MTL_ITEM_LOCATIONS S
           where S.ORGANIZATION_ID = CR_PO_LINE.SHIP_TO_ORGANIZATION_ID
             and S.SEGMENT1 =P_LOCATION--'02-01-01'-- 'C1-03-01'--P_RCV_LOCATION
             ;
        exception
          when others then
            MSG_OUTPUT(CR_PO_LINE.SHIP_TO_ORGANIZATION_ID || ',' ||
                                 '找不到货位 .');
            raise ERR_OTHERS;
        end;
        
				BEGIN
				--L_IFACE_RCV_REC.PARENT_TRANSACTION_ID      := CR_PO_LINE.PARENT_TRANSACTION_ID;
				SELECT R.TRANSACTION_ID
				INTO L_IFACE_RCV_REC.PARENT_TRANSACTION_ID
				FROM RCV_TRANSACTIONS R
				WHERE --R.TRANSACTION_ID=1260537
				R.Parent_Transaction_Id=CR_PO_LINE.PARENT_TRANSACTION_ID--1260537
				AND r.transaction_type='DELIVER'
				;
				 exception
          when others then
            MSG_OUTPUT(CR_PO_LINE.PARENT_TRANSACTION_ID || ',' ||
                                 '找不到 DELIVER 的 TRANSACTION_ID .');
            raise ERR_OTHERS;
				END;
				
				L_IFACE_RCV_REC.currency_conversion_rate   := CR_PO_LINE.currency_conversion_rate;--ADD TEST
				L_IFACE_RCV_REC.SHIPMENT_HEADER_ID         := CR_PO_LINE.SHIPMENT_HEADER_ID;   
				L_IFACE_RCV_REC.SHIPMENT_LINE_ID           := CR_PO_LINE.SHIPMENT_LINE_ID;              
        L_IFACE_RCV_REC.From_Organization_Id         := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;      
        L_IFACE_RCV_REC.TO_ORGANIZATION_ID         := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;
        L_IFACE_RCV_REC.VENDOR_ID                  := CR_PO_LINE.VENDOR_ID;
        L_IFACE_RCV_REC.VENDOR_SITE_ID             := CR_PO_LINE.VENDOR_SITE_ID;
        L_IFACE_RCV_REC.ITEM_ID                    := CR_PO_LINE.ITEM_ID;
        L_IFACE_RCV_REC.ITEM_DESCRIPTION           := CR_PO_LINE.ITEM_DESCRIPTION;
        L_IFACE_RCV_REC.CATEGORY_ID                := CR_PO_LINE.CATEGORY_ID;
        L_IFACE_RCV_REC.SOURCE_DOC_UNIT_OF_MEASURE := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.UNIT_OF_MEASURE            := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.UOM_CODE                   := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.QUANTITY                   := GMICUOM.UOM_CONVERSION(L_OPM_ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             CR_PO_LINE.Trans_Um,
																																						 CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                             0);--CR_PO_LINE.QUANTITY;
        L_IFACE_RCV_REC.PO_UNIT_PRICE              := CR_PO_LINE.UNIT_PRICE;
        L_IFACE_RCV_REC.SECONDARY_QUANTITY         := GMICUOM.UOM_CONVERSION(L_OPM_ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             CR_PO_LINE.Trans_Um,
                                                                             CR_PO_LINE.SECONDARY_UOM_CODE,
                                                                             0);

        L_IFACE_RCV_REC.SECONDARY_UNIT_OF_MEASURE := CR_PO_LINE.SECONDARY_UOM_CODE;
        L_IFACE_RCV_REC.SECONDARY_UOM_CODE        := CR_PO_LINE.SECONDARY_UOM_CODE;
        L_IFACE_RCV_REC.PRIMARY_UNIT_OF_MEASURE   := CR_PO_LINE.PRIMARY_UNIT_OF_MEASURE;
        L_IFACE_RCV_REC.PRIMARY_QUANTITY          := GMICUOM.UOM_CONVERSION(L_OPM_ITEM_ID,
                                                                            0,
                                                                            P_QTY,
                                                                             CR_PO_LINE.Trans_Um,
                                                                            CR_PO_LINE.PRIMARY_UNIT_OF_MEASURE,
                                                                            0);

        L_IFACE_RCV_REC.SOURCE_DOC_QUANTITY := GMICUOM.UOM_CONVERSION(L_OPM_ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             CR_PO_LINE.Trans_Um,
                                                                             CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                             0);--CR_PO_LINE.QUANTITY;
        L_IFACE_RCV_REC.PO_HEADER_ID        := CR_PO_LINE.PO_HEADER_ID;
        L_IFACE_RCV_REC.ROUTING_HEADER_ID   := 3;
        L_IFACE_RCV_REC.PO_LINE_ID          := CR_PO_LINE.PO_LINE_ID;
        L_IFACE_RCV_REC.PO_DISTRIBUTION_ID  := CR_PO_LINE.PO_DISTRIBUTION_ID;
        L_IFACE_RCV_REC.PO_LINE_LOCATION_ID := CR_PO_LINE.LINE_LOCATION_ID;

       -- L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE := CR_PO_LINE.NEED_BY_DATE;

        L_IFACE_RCV_REC.USE_MTL_LOT := 2;--2：启用批次控制；1：不启用批次控制
        L_IFACE_RCV_REC.EMPLOYEE_ID := CR_PO_LINE.AGENT_ID;

        L_IFACE_RCV_REC.USE_MTL_SERIAL := 1;--2：启用序列；1：不启用序列；

        L_IFACE_RCV_REC.ROUTING_STEP_ID := 1;

        L_IFACE_RCV_REC.LAST_UPDATE_LOGIN := P_USER_ID;
        L_IFACE_RCV_REC.LAST_UPDATED_BY   := P_USER_ID;
        L_IFACE_RCV_REC.CREATED_BY        := P_USER_ID;
        L_IFACE_RCV_REC.CREATION_DATE     := sysdate;
        L_IFACE_RCV_REC.LAST_UPDATE_DATE  := sysdate;
		/*		
				IF L_COUNT =1
					THEN
				BEGIN
				L_TRANS:='INSERT rcv_headers_interface';
			
				select rcv_headers_interface_s.nextval
          into L_IFACE_RCV_REC.HEADER_INTERFACE_ID
          from DUAL;

				
				INSERT INTO rcv_headers_interface
(header_interface_id
,group_id
,processing_status_code
,receipt_source_code
,transaction_type
,last_update_date
,last_updated_by
,last_update_login
,creation_date
,created_by
,vendor_id
,vendor_site_id
,validation_flag
,employee_id
,expected_receipt_date
,comments )
VALUES ( 
L_IFACE_RCV_REC.HEADER_INTERFACE_ID--rcv_headers_interface_s.NEXTVAL --header_interface_id
,L_GROUP_ID--rcv_interface_groups_s.NEXTVAL--group_id
,L_IFACE_RCV_REC.PROCESSING_STATUS_CODE--processing_status_code
,L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE--receipt_source_code
,L_IFACE_RCV_REC.TRANSACTION_TYPE--transaction_type
,L_IFACE_RCV_REC.LAST_UPDATE_DATE--last_update_date
,L_IFACE_RCV_REC.LAST_UPDATED_BY--last_updated_by
,L_IFACE_RCV_REC.LAST_UPDATE_LOGIN--last_update_login
,L_IFACE_RCV_REC.CREATION_DATE--creation_date
,L_IFACE_RCV_REC.CREATED_BY--created_by
,L_IFACE_RCV_REC.VENDOR_ID --vendor_id
,L_IFACE_RCV_REC.VENDOR_SITE_ID--vendor_site_id
,'Y'--validation_flag
,L_IFACE_RCV_REC.EMPLOYEE_ID--employee_id
,L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE--expected_receipt_date
,P_REMARK--comments 
);
		    
				exception
					when others THEN
						L_MSG:=L_MSG||' INSERT rcv_headers_interface ERROR';
					RAISE err_others;
				END;
				END IF;
				*/
        insert into PO.RCV_TRANSACTIONS_INTERFACE
          (INTERFACE_TRANSACTION_ID,
           ITEM_DESCRIPTION,
           RECEIPT_SOURCE_CODE,
           SOURCE_DOC_UNIT_OF_MEASURE,
           UNIT_OF_MEASURE,
           PRIMARY_UNIT_OF_MEASURE,
           UOM_CODE,
           CURRENCY_CODE,
           TRANSACTION_TYPE,
           INTERFACE_SOURCE_CODE,
           SOURCE_DOCUMENT_CODE,
           PROCESSING_STATUS_CODE,
           TRANSACTION_STATUS_CODE,
           INSPECTION_STATUS_CODE,
           DESTINATION_CONTEXT,
           DESTINATION_TYPE_CODE,
           AUTO_TRANSACT_CODE,
           fROm_subinventory,
           PROCESSING_MODE_CODE,
           TO_ORGANIZATION_ID,
           PO_HEADER_ID,
           GROUP_ID,
           VENDOR_ID,
           VENDOR_SITE_ID,
           ITEM_ID,
           ROUTING_HEADER_ID,
           SHIPMENT_HEADER_ID,
           LAST_UPDATE_LOGIN,
           LAST_UPDATED_BY,
           CREATED_BY,
           PO_LINE_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           EXPECTED_RECEIPT_DATE,
           TRANSACTION_DATE,
           USE_MTL_LOT,
           EMPLOYEE_ID,
           PO_DISTRIBUTION_ID,
           PO_LINE_LOCATION_ID,
           SHIP_TO_LOCATION_ID,
           CATEGORY_ID,
           --LOCATOR_ID,
					 FROM_LOCATOR_ID,
           USE_MTL_SERIAL,
           SOURCE_DOC_QUANTITY,
           PO_UNIT_PRICE,
           ROUTING_STEP_ID,
           PRIMARY_QUANTITY,
           QUANTITY,
           SECONDARY_QUANTITY,
           SECONDARY_UNIT_OF_MEASURE
					 ,PARENT_TRANSACTION_ID--ADD TEST
					 ,CREATE_DEBIT_MEMO_FLAG--ADD TEST
					 ,SHIPMENT_LINE_ID--ADD TEST
					 ,From_Organization_Id--ADD TEST
					 ,currency_conversion_rate--ADD TEST
           ,vendor_lot_num --add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
           ,comments --add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
           
					 )
        values
          (L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID,
           L_IFACE_RCV_REC.ITEM_DESCRIPTION,
           L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE,
           L_IFACE_RCV_REC.SOURCE_DOC_UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.PRIMARY_UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.UOM_CODE,
           L_IFACE_RCV_REC.CURRENCY_CODE,
           L_IFACE_RCV_REC.TRANSACTION_TYPE,
           L_IFACE_RCV_REC.INTERFACE_SOURCE_CODE,
           L_IFACE_RCV_REC.SOURCE_DOCUMENT_CODE,
           L_IFACE_RCV_REC.PROCESSING_STATUS_CODE,
           L_IFACE_RCV_REC.TRANSACTION_STATUS_CODE,
           L_IFACE_RCV_REC.INSPECTION_STATUS_CODE,
           L_IFACE_RCV_REC.DESTINATION_CONTEXT,
           L_IFACE_RCV_REC.DESTINATION_TYPE_CODE,
           L_IFACE_RCV_REC.AUTO_TRANSACT_CODE,
           L_IFACE_RCV_REC.frOm_subinventory,
           L_IFACE_RCV_REC.PROCESSING_MODE_CODE,
           L_IFACE_RCV_REC.TO_ORGANIZATION_ID,
           L_IFACE_RCV_REC.PO_HEADER_ID,
           L_IFACE_RCV_REC.GROUP_ID,
           L_IFACE_RCV_REC.VENDOR_ID,
           L_IFACE_RCV_REC.VENDOR_SITE_ID,
           L_IFACE_RCV_REC.ITEM_ID,
           L_IFACE_RCV_REC.ROUTING_HEADER_ID,
           L_IFACE_RCV_REC.SHIPMENT_HEADER_ID,
           L_IFACE_RCV_REC.LAST_UPDATE_LOGIN,
           L_IFACE_RCV_REC.LAST_UPDATED_BY,
           L_IFACE_RCV_REC.CREATED_BY,
           L_IFACE_RCV_REC.PO_LINE_ID,
           L_IFACE_RCV_REC.CREATION_DATE,
           L_IFACE_RCV_REC.LAST_UPDATE_DATE,
           L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE,
           L_IFACE_RCV_REC.TRANSACTION_DATE,
           L_IFACE_RCV_REC.USE_MTL_LOT,
           L_IFACE_RCV_REC.EMPLOYEE_ID,
           L_IFACE_RCV_REC.PO_DISTRIBUTION_ID,
           L_IFACE_RCV_REC.PO_LINE_LOCATION_ID,
           L_IFACE_RCV_REC.SHIP_TO_LOCATION_ID,
           L_IFACE_RCV_REC.CATEGORY_ID,
           --L_IFACE_RCV_REC.LOCATOR_ID,
					 L_IFACE_RCV_REC.FROM_LOCATOR_ID,
           L_IFACE_RCV_REC.USE_MTL_SERIAL,
           L_IFACE_RCV_REC.SOURCE_DOC_QUANTITY,
           L_IFACE_RCV_REC.PO_UNIT_PRICE,
           L_IFACE_RCV_REC.ROUTING_STEP_ID,
           L_IFACE_RCV_REC.PRIMARY_QUANTITY,
           L_IFACE_RCV_REC.QUANTITY,
           L_IFACE_RCV_REC.SECONDARY_QUANTITY,
           L_IFACE_RCV_REC.SECONDARY_UNIT_OF_MEASURE
					 ,L_IFACE_RCV_REC.PARENT_TRANSACTION_ID--ADD TEST
					 ,L_IFACE_RCV_REC.CREATE_DEBIT_MEMO_FLAG --ADD TEST
					 ,L_IFACE_RCV_REC.SHIPMENT_LINE_ID--ADD TEST
					 ,L_IFACE_RCV_REC.From_Organization_Id--ADD TEST
					 ,L_IFACE_RCV_REC.currency_conversion_rate--ADD TEST
					 ,L_IFACE_RCV_REC.Vendor_Lot_Num  --add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
           ,L_IFACE_RCV_REC.Comments--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
					 
					 );

        if L_LOT_CTR + L_SUB_CTR = 0
        then
          null;
        else
          L_IFACE_LOT.LAST_UPDATE_DATE  := sysdate;
          L_IFACE_LOT.LAST_UPDATED_BY   := P_USER_ID;
          L_IFACE_LOT.CREATION_DATE     := sysdate;
          L_IFACE_LOT.CREATED_BY        := P_USER_ID;
          L_IFACE_LOT.LAST_UPDATE_LOGIN := -1;

          L_IFACE_LOT.INTERFACE_TRANSACTION_ID := L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID;
          L_IFACE_LOT.QUANTITY                 := L_IFACE_RCV_REC.QUANTITY;
          L_IFACE_LOT.PRIMARY_QUANTITY         := L_IFACE_RCV_REC.PRIMARY_QUANTITY;
          L_IFACE_LOT.ITEM_ID                  := L_IFACE_RCV_REC.ITEM_ID;
          L_IFACE_LOT.TRANSACTION_DATE         := L_IFACE_RCV_REC.TRANSACTION_DATE;
          --L_IFACE_LOT.EXPIRATION_DATE          := L_IFACE_RCV_REC.TRANSACTION_DATE + 365;
          L_IFACE_LOT.SECONDARY_QUANTITY       := L_IFACE_RCV_REC.SECONDARY_QUANTITY;
          L_IFACE_LOT.LOT_NUM                  := CR_PO_LINE.LOT_NO;--P_RCV_LOT_NUM;
          if L_SUB_CTR = 1
          then
            L_IFACE_LOT.SUBLOT_NUM := CR_PO_LINE.SUBLOT_NO;--P_RCV_SUBLOT_NUM;
          else
            L_IFACE_LOT.SUBLOT_NUM := null;
          end if;
/*
          select count(*)
            into V_COUNT
            from IC_LOTS_MST T
           where T.LOT_NO = L_IFACE_LOT.LOT_NUM
             and T.ITEM_ID = L_OPM_ITEM_ID
             and NVL(T.SUBLOT_NO,
                     1) = NVL(L_IFACE_LOT.SUBLOT_NUM,
                              1);
          if V_COUNT = 0
          then
            L_LOT_ID := CUX_DEVELOP_LCJ_PKG.IC_LOT_CREATE(V_ITEM_ID          => L_OPM_ITEM_ID,
                                                          V_LOT_NO           => L_IFACE_LOT.LOT_NUM,
                                                          V_SUBLOT_NO        => L_IFACE_LOT.SUBLOT_NUM,
                                                          V_ORIGINATION_TYPE => 2,
                                                          V_SHIPVEND_ID      => L_SHIPVEND_ID,
                                                          V_VENDOR_LOT_NO    => L_IFACE_RCV_REC.Vendor_Lot_Num,--CHANGE by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息--null,
                                                          V_RECV_DATE        => L_DOC_DATE,
                                                          V_QC_GRADE         => L_QC_GRADE,
                                                          V_LOT_DESC         => L_LOT_DESC,
                                                          V_COMMIT           => 'T');
          end if;
*/
          insert into RCV_LOTS_INTERFACE
            (LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             CREATION_DATE,
             CREATED_BY,
             LAST_UPDATE_LOGIN,
             INTERFACE_TRANSACTION_ID,
             QUANTITY,
             PRIMARY_QUANTITY,
             ITEM_ID,
             TRANSACTION_DATE,
             LOT_NUM,
             SUBLOT_NUM,
             EXPIRATION_DATE,
             SECONDARY_QUANTITY)
          values
            (L_IFACE_LOT.LAST_UPDATE_DATE,
             L_IFACE_LOT.LAST_UPDATED_BY,
             L_IFACE_LOT.CREATION_DATE,
             L_IFACE_LOT.CREATED_BY,
             L_IFACE_LOT.LAST_UPDATE_LOGIN,
             L_IFACE_LOT.INTERFACE_TRANSACTION_ID,
             L_IFACE_LOT.QUANTITY,
             L_IFACE_LOT.PRIMARY_QUANTITY,
             L_IFACE_LOT.ITEM_ID,
             L_IFACE_LOT.TRANSACTION_DATE,
             L_IFACE_LOT.LOT_NUM,
             L_IFACE_LOT.SUBLOT_NUM,
             L_IFACE_LOT.EXPIRATION_DATE,
             L_IFACE_LOT.SECONDARY_QUANTITY);
                    
          mtl_transaction_lots_interfac.last_update_date       := SYSDATE;  
          mtl_transaction_lots_interfac.last_updated_by        := P_USER_ID;--fnd_global.user_id;  
          mtl_transaction_lots_interfac.creation_date          := SYSDATE;  
          mtl_transaction_lots_interfac.created_by             := P_USER_ID;--fnd_global.user_id;  
          mtl_transaction_lots_interfac.last_update_login      := -1;  
          mtl_transaction_lots_interfac.product_code           := 'RCV';  
          mtl_transaction_lots_interfac.product_transaction_id :=  L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID;--rcv_transactions_interface.interface_transaction_id;  
          mtl_transaction_lots_interfac.lot_number             := L_IFACE_LOT.LOT_NUM;--P_RCV_LOT_NUM;--rec_line.lot_number;  
					mtl_transaction_lots_interfac.sublot_num             :=  L_IFACE_LOT.SUBLOT_NUM;
          mtl_transaction_lots_interfac.transaction_quantity   := L_IFACE_RCV_REC.QUANTITY;--l_iface_rcv_rec.quantity;  
          mtl_transaction_lots_interfac.primary_quantity       := L_IFACE_RCV_REC.PRIMARY_QUANTITY;--l_primary_qty;  
          
          SELECT mtl_material_transactions_s.NEXTVAL  
          INTO   mtl_transaction_lots_interfac.transaction_interface_id  
          FROM   dual;  
          
         -- l_primary_qty :=1;  
          
          INSERT INTO mtl_transaction_lots_interface VALUES mtl_transaction_lots_interfac;  
           
        end if;
      end loop;
    
    commit;
		
		 MSG_OUTPUT('L_group_id: '||L_group_id);
		/* 
				 FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID,
                               RESP_ID      => 20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RCVDLPDT', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,  
                            \* L_group_id,--*\'P_group_id=' || L_group_id,  
                           \* 'Supplier',-- *\'P_receipt_source_type=Supplier',  
                           \* '2',-- *\'P_qty_precision=2',  
                            \*L_CUR_MFG_ORG_ID,-- *\'P_org_id=' || L_CUR_MFG_ORG_ID
                                               ,CHR(0)
																							 );

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
				 L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
				 L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
		  */
    L_RETURN_STATUS := 'S';
       L_MSG:=L_MSG||'采购退货接口事务产生完成';
      -- L_MSG:=L_MSG||'传入参数：L_CO_CODE: '||l_co_code||',l_period_code: '||l_period_code;--||',l_type: '||l_type;
    l_err_MSG:=L_MSG;
      /* FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================result========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||l_err_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'L_RETURN_STATUS： '||L_RETURN_STATUS);--日志输出
        */
        MSG_OUTPUT('================result========================');
        MSG_OUTPUT('L_RETURN_STATUS: '||L_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||l_err_MSG);/*
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,256,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,500,255));
				
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,756,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1000,255));*/
		  exception
      WHEN err_others THEN
        L_RETURN_STATUS := 'E';
       L_MSG:=L_MSG||';'||L_TRANS||' 退货接口过程异常退出';--' 退货接口过程异常退出,采购退货过程传入参数：P_WHSE_CODE: '||P_WHSE_CODE||',P_RCV_NO: '||P_RCV_NO||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE_ON: '||P_WHSE_CODE_ON||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK;--||',l_type: '||l_type;
        l_err_MSG:=L_MSG||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('L_RETURN_STATUS: '||L_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||l_err_MSG);/*
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,256,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,500,255));
				
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,756,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1000,255));*/
        /*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||l_err_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'L_RETURN_STATUS： '||L_RETURN_STATUS);--日志输出
        */
      when others then
       L_RETURN_STATUS := 'E';
        l_err_MSG:=L_MSG||';'||L_TRANS||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('L_RETURN_STATUS: '||L_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||l_err_MSG);
       /* MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,256,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,500,255));
				
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,756,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1000,255));*/
        
        /*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||l_err_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'L_RETURN_STATUS： '||L_RETURN_STATUS);--日志输出
        */

  end;
	/*
	\*###############################################################
  # NAME
  #  PO_RCV
  # SYNOPSIS
  #  proc PO_RCV
  # DESCRIPTION
  #  1、采购订单获取逻辑，取当月月底前包含这个品种的采购订单的最大订单号，验证订单行“需要日期”
	#  或“承诺日期”<=月底最后一天
	###############################################################*\				
  procedure PO_RCV(P_FROM_CO_CODE IN VARCHAR2--生产的分厂
                  ,P_TO_CO_CODE IN VARCHAR2--采购接收的分厂
                  ,P_TYPE       IN VARCHAR2--类型：D:采购接收；R：采购退货；
                  ,P_PX_ID      IN NUMBER--瓶箱传入的唯一的id
                  ,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,P_LOT_ID     IN NUMBER
                  ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  ,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_QTY        IN NUMBER--接收数量，第一单位数量
                  ,p_um         IN VARCHAR2--接收数量对应的单位
                  ,P_REMARK     IN VARCHAR2--备注
									,P_USER_NAME  IN VARCHAR2--用户名，可为空，空的时候默认：CY_ZCM
                  ,L_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,l_err_MSG OUT varchar2--错误信息返回
    ) is
    cursor C is
      select distinct H.PO_HEADER_ID,
                      H.SEGMENT1
        from PO_HEADERS_ALL H
       where H.TYPE_LOOKUP_CODE = 'STANDARD'
         and H.AUTHORIZATION_STATUS = 'APPROVED'
         --and H.INTERFACE_SOURCE_CODE like P_PO_REMARK
         --AND H.CREATION_DATE LIKE SYSDATE--限制当天创建的猫单的采购订单才接受
         AND H.SEGMENT1 =\*38655--*\38645--38642--38641--38647--38638--IN ('28682','28683')--JUST FOR TEST
         ;
    CR            C%rowtype;
    V_PHASE       varchar2(100);
    V_STATUS      varchar2(100);
    V_DEV_PHASE   varchar2(100);
    V_DEV_STATUS  varchar2(100);
    V_MESSAGE     varchar2(400);
    L_REQUEST_ID  number;
    V_STATUS_CODE varchar2(1);
    V_PHASE_CODE  varchar2(1);
    L_RESP_ID   NUMBER;
		
		L_TRANS                    VARCHAR2(1000);
		L_MSG                      VARCHAR2(4000);
		L_COUNT                    NUMBER:=0;
		L_ITEM_NO                  VARCHAR2(240);
  BEGIN
    --L_TRANS:='参数有效性校验';
		--------------------------------传入参数校验 start--------------------------------------
		BEGIN
		L_TRANS:='发货方组织检查';
		L_COUNT:=0;
		SELECT COUNT(*)--g.co_code, g.org_id, g.sob_id, g.set_of_books_name,G.OPERATING_UNIT, g.*
		INTO L_COUNT
    FROM GL_PLCY_MST G
	  WHERE G.CO_CODE =P_FROM_CO_CODE
	;
	  IF L_COUNT<1
			THEN
				L_MSG:=L_MSG||' 参数错误：发货方组织检查';
				RAISE err_others;
		END IF;
		
		exception
      when others THEN
				L_MSG:=L_MSG||' 参数错误：发货方组织检查';
      RAISE err_others;
		END;
		
		BEGIN
    L_TRANS:='采购接收方组织检查';
		L_COUNT:=0;
    SELECT COUNT(*)--g.co_code, g.org_id, g.sob_id, g.set_of_books_name,G.OPERATING_UNIT, g.*
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =P_TO_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：采购接收方组织检查';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：采购接收方组织检查';
      RAISE err_others;
    END;
		
		BEGIN
    L_TRANS:='类型检查';
    IF NVL(P_TYPE,-1) NOT IN ('D','R')
      THEN
        L_MSG:=L_MSG||' 参数错误：类型检查';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：类型检查';
      RAISE err_others;
    END;
		
		BEGIN
    L_TRANS:='PX_ID检查';
    IF P_PX_ID IS NULL
      THEN
        L_MSG:=L_MSG||' 参数错误：PX_ID不能为空';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：PX_ID不能为空';
      RAISE err_others;
    END;
		
		BEGIN
    L_TRANS:='P_ITEM_ID检查';
		L_COUNT:=0;
		SELECT COUNT(*)
		INTO l_count
		FROM IC_ITEM_MST_B B
		WHERE B.ITEM_ID=P_ITEM_ID
		;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：不存在P_ITEM_ID：'||P_ITEM_ID||' 的item； ';
        RAISE err_others;
    END IF;
		
    L_COUNT:=0;
		SELECT COUNT(*)
		INTO l_count
		FROM IC_ITEM_MST_B B
		WHERE B.ITEM_ID=P_ITEM_ID
		AND (B.DELETE_MARK=1
		OR B.INACTIVE_IND=1)
		;
    IF l_count >0
      THEN
        L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||' 已经被标记为删除或无效； ';
        RAISE err_others;
    END IF;
		
		L_COUNT:=0;
		SELECT B.ITEM_NO
    INTO L_ITEM_NO
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=P_ITEM_ID
    AND (B.DELETE_MARK=0
    OR B.INACTIVE_IND=0)
		AND b.item_desc1 NOT LIKE '%原浆%'
    ;
		IF L_ITEM_NO LIKE '05-1-1%'
			THEN
		  IF SUBSTR(L_ITEM_NO,INSTR(L_ITEM_NO,'-',-1,2)+1,INSTR(L_ITEM_NO,'-',-1,1)-INSTR(L_ITEM_NO,'-',-1,2)-1)<>'6'--非净水库存
				THEN
				L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||' 传入的不是净水成品就的item_id； ';
        RAISE err_others;
			END IF;
		END IF;
		
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_ITEM_ID检查';
      RAISE err_others;
    END;
		
		BEGIN
    L_TRANS:='P_LOT_ID 检查';
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_LOTS_MST L
    WHERE L.ITEM_ID=P_ITEM_ID
		AND L.LOT_ID=P_LOT_ID
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：不存在 P_ITEM_ID：'||P_ITEM_ID||' , P_LOT_ID：'||P_LOT_ID||'； ';
        RAISE err_others;
    END IF;
       
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_LOT_ID 检查';
      RAISE err_others;
    END;
		
		BEGIN
    L_TRANS:='P_TRANS_DATE 检查';
		--验证 P_TRANS_DATE 采购期间有没有打开，总账期间有没有打开，库存期间有没有打开
		L_COUNT:=0;
		SELECT  COUNT(*)--p.closing_status --'O'是打开,
		INTO l_count
  FROM GL_PERIOD_STATUSES P,
       fnd_user           f,
       FND_APPLICATION_VL A,
       GL_SETS_OF_BOOKS_V S
       ,GL_PLCY_MST G
 WHERE p.last_updated_by = f.user_id
   and p.application_id = a.application_id
   and p.set_of_books_id = s.set_of_books_id
   AND G.SOB_ID=S.SET_OF_BOOKS_ID
	 
	 AND P_TRANS_DATE >=P.START_DATE
	 AND P_TRANS_DATE <=P.END_DATE
	 AND G.CO_CODE=P_TO_CO_CODE
	 AND A.APPLICATION_SHORT_NAME ='PO'--SQLGL 
	 AND p.closing_status='O'
	 ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||' ,采购期间没打开； ';
        RAISE err_others;
    END IF;
		
		L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM GL_PERIOD_STATUSES P,
       fnd_user           f,
       FND_APPLICATION_VL A,
       GL_SETS_OF_BOOKS_V S
       ,GL_PLCY_MST G
 WHERE p.last_updated_by = f.user_id
   and p.application_id = a.application_id
   and p.set_of_books_id = s.set_of_books_id
   AND G.SOB_ID=S.SET_OF_BOOKS_ID
   
   AND TRUNC(add_months(P_TRANS_DATE,-1),'DD') >=P.START_DATE
   AND TRUNC(add_months(P_TRANS_DATE,-1),'DD') <=P.END_DATE
   AND G.CO_CODE=P_TO_CO_CODE
   AND A.APPLICATION_SHORT_NAME =\*'PO'--*\'SQLGL'
   AND p.closing_status='O'
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||' ,集成总账期间没打开； ';
        RAISE err_others;
    END IF;
       
		L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM ORG_ACCT_PERIODS_V B, IC_WHSE_MST W,ORG_ORGANIZATION_DEFINITIONS A
 WHERE B.ORGANIZATION_ID = W.MTL_ORGANIZATION_ID
	 AND A.ORGANIZATION_ID=B.organization_id
	 
   AND W.WHSE_CODE =P_WHSE_CODE
   AND P_TRANS_DATE >=B.start_date
   AND P_TRANS_DATE <=B.end_date
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||',P_WHSE_CODE:'||P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
       
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE 检查';
      RAISE err_others;
    END;
		
	BEGIN
		L_TRANS:='P_WHSE_CODE 检查';
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
     FROM SY_ORGN_MST_VL A, IC_WHSE_MST W,GL_PLCY_MST G
 WHERE A.ORGN_CODE = W.ORGN_CODE
 AND A.CO_CODE=G.CO_CODE
   AND W.DELETE_MARK = 0
   AND A.DELETE_MARK = 0
   AND A.ORGN_CODE <> A.PARENT_ORGN_CODE
   AND A.PARENT_ORGN_CODE NOT LIKE '%LAB%'
   AND A.PARENT_ORGN_CODE NOT LIKE 'JT'
   AND W.WHSE_CODE = P_WHSE_CODE\*
   AND A.PARENT_ORGN_CODE LIKE &PARENT_ORGN_CODE --'GF'
	 AND A.CO_CODE LIKE &CO_CODE*\
  ;
    IF L_COUNT<1
      THEN
         L_MSG:=L_MSG||' 参数错误：P_WHSE_CODE：'||P_WHSE_CODE||' ,接收仓库无效或不存在； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 P_WHSE_CODE 检查';
      RAISE err_others;
    END;		
		
	BEGIN
		L_TRANS:='P_LOCATION 检查';
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
     from ic_loct_mst l, ic_whse_mst w
 where l.whse_code = w.whse_code
 AND W.WHSE_CODE =P_WHSE_CODE
 AND L.LOCATION =P_LOCATION
 AND w.delete_mark=0
 AND l.delete_mark=0
  ;
    IF L_COUNT<1
      THEN
         L_MSG:=L_MSG||' 参数错误：P_LOCATION：'||P_LOCATION||',P_WHSE_CODE:'||P_WHSE_CODE||' ,接收货位无效或不存在； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 P_LOCATION 检查';
      RAISE err_others;
    END;	
		
	BEGIN
		L_TRANS:='P_QTY 检查';
		IF P_QTY<=0
			THEN
         L_MSG:=L_MSG||' 参数错误：P_QTY：'||P_QTY||' ,数量请填正数； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 P_QTY 检查';
      RAISE err_others;
    END;
		
    BEGIN
    L_TRANS:='p_um 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=P_ITEM_ID
		AND B.ITEM_UM=p_um
    AND (B.DELETE_MARK=0
    OR B.INACTIVE_IND=0)
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||',p_um:'||p_um||' 不是第一单位，请传入第一单位数量和第一单位； ';
        RAISE err_others;
    END IF;
   
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：p_um 检查';
      RAISE err_others;
    END;
									
		--P_USER_NAME 不为空的时候，要获取 user_ID 到 P_USER_ID 做初始化
		--空的时候，默认用户 CY_ZCM
		--要验证接受用户，订单的接收仓库，的用户组织，仓管员权限，是否已经有，没的话报错
		--订单的接收组织和传入参数的接收仓库组织是否 一致 不一致报错
		BEGIN
		L_TRANS:='P_USER_NAME 检查';
		IF P_USER_NAME IS NOT NULL
			THEN
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM FND_USER F
WHERE F.USER_NAME = P_USER_NAME
--AND F.USER_ID LIKE &USER_ID
AND NVL(F.END_DATE,SYSDATE+1)>SYSDATE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_NAME：'||P_USER_NAME||' ,用户名不存在或已经被无效； ';
        RAISE err_others;
    END IF;
		
		SELECT F.USER_ID
		INTO P_USER_ID
		 FROM FND_USER F
WHERE F.USER_NAME = P_USER_NAME
--AND F.USER_ID LIKE &USER_ID
AND NVL(F.END_DATE,SYSDATE+1)>SYSDATE
		;
		
    END IF;
		
		--用户组织检查
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM SY_ORGN_USR A,FND_USER F,IC_WHSE_MST W
WHERE A.USER_ID=F.USER_ID
AND A.ORGN_CODE=W.ORGN_CODE
AND A.USER_ID=P_USER_ID
AND W.WHSE_CODE=P_WHSE_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_ID：'||P_USER_ID||',P_WHSE_CODE:'|| P_WHSE_CODE||' ,用户没有分配接收仓库的用户组织； ';
        RAISE err_others;
    END IF;
		
		--仓管员权限检查
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM CUX_req_whse_manager_v A
WHERE A.WHSE_CODE=P_WHSE_CODE
AND A.USER_ID=P_USER_ID
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_ID：'||P_USER_ID||',P_WHSE_CODE:'|| P_WHSE_CODE||' ,用户没有分配接收仓库的仓管员权限； ';
        RAISE err_others;
    END IF;
		
		
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_NAME 检查';
      RAISE err_others;
    END;
		
		\*--追加格式
		BEGIN
		L_TRANS:='XXXX 检查';
		L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =P_TO_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||',P_WHSE_CODE:'||P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：XXXX 检查';
      RAISE err_others;
    END;
		*\
		--------------------------------传入参数校验 END--------------------------------------
		
     IF P_TO_CO_CODE LIKE 'GF'
      THEN
        L_RESP_ID:=50311;--GF.采购接收--20707;--采购超级用户
    ELSE
      SELECT DISTINCT
       Z.RESPONSIBILITY_ID
       INTO L_RESP_ID
        FROM FND_RESPONSIBILITY_VL Z
       WHERE Z.APPLICATION_ID = 201 --222--401
       AND Z.RESPONSIBILITY_NAME LIKE P_TO_CO_CODE||'%Purchasing Super User%'

      ;
    END IF;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201)
                         ;
		IF P_TYPE = 'D'
			THEN																
    for CR in C
    loop
      MSG_OUTPUT('开始接收订单' || ':' || CR.SEGMENT1);
      CREATE_PO_RCV(P_TO_CO_CODE,CR.PO_HEADER_ID);
      MSG_OUTPUT('完成接收订单' || ':' || CR.SEGMENT1);
    end loop;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID,
                               RESP_ID      => 20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RVCTP', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,
                                               'BATCH',
                                               null,
                                               CHR(0));

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
				 L_MSG:=L_MSG||'采购接收请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
				 L_MSG:=L_MSG||'采购接收请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
		
		ELSIF P_TYPE = 'R'
			THEN	
				CREATE_PO_RETURN('PX21'--P_WHSE_CODE  
                          ,'71567'--P_RCV_NO  
                          ,P_ITEM_ID   
                          ,P_LOT_ID    
                          ,P_TRANS_DATE  --采购接收或退货事务时间
                          ,P_WHSE_CODE   --接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,P_LOCATION    --接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,P_QTY         --接收数量,退货数量，第一单位数量
                          ,p_um          --接收数量对应的单位
                          ,P_REMARK     --备注
                          ,L_RETURN_STATUS --返回状态：S-正常完成，E-异常终止
                          ,V_MESSAGE --错误信息返回                          
                          )
													;
				
		  if L_RETURN_STATUS not in ('S')
      THEN
				 L_MSG:=L_MSG||' ；采购退货接口报错：'||V_MESSAGE;
        raise ERR_OTHERS;
			ELSE
				L_MSG:=L_MSG||'采购退货接口写入完成；';
      end if;
			
			  FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID,
                               RESP_ID      => 20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RVCTP', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,
                                               'BATCH',
                                               null,
                                               CHR(0));

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
				 L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
				 L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
		
			
		
		END IF;
		
		L_RETURN_STATUS := 'S';
       L_MSG:=L_MSG||'采购接口事务产生完成';
      -- L_MSG:=L_MSG||'传入参数：L_CO_CODE: '||l_co_code||',l_period_code: '||l_period_code;--||',l_type: '||l_type;
    l_err_MSG:=L_MSG;
      \* FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================result========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||l_err_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'L_RETURN_STATUS： '||L_RETURN_STATUS);--日志输出
				*\
				MSG_OUTPUT('================result========================');
        MSG_OUTPUT('L_RETURN_STATUS: '||L_RETURN_STATUS);
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1,255));
				MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,256,255));
				MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,500,255));
				
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,756,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1000,255));
        
		  exception
      WHEN err_others THEN
        L_RETURN_STATUS := 'E';
       L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出,主体传入参数：P_FROM_CO_CODE: '||P_FROM_CO_CODE||',P_TO_CO_CODE: '||P_TO_CO_CODE||',P_TYPE: '||P_TYPE||',P_PX_ID: '||P_PX_ID||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        l_err_MSG:=L_MSG||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('L_RETURN_STATUS: '||L_RETURN_STATUS);
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1,255));
				MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,256,255));
				MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,500,255));
				
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,756,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1000,255));
        \*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||l_err_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'L_RETURN_STATUS： '||L_RETURN_STATUS);--日志输出
        *\
      when others then
       L_RETURN_STATUS := 'E';
        l_err_MSG:=L_MSG||';'||L_TRANS||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('L_RETURN_STATUS: '||L_RETURN_STATUS);
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1,255));
				MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,256,255));
				MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,500,255));
				
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,756,255));
        MSG_OUTPUT(SUBSTR('l_err_MSG: '||l_err_MSG,1000,255));
        
        \*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||l_err_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'L_RETURN_STATUS： '||L_RETURN_STATUS);--日志输出
				*\
  end;
*/

  
  /*###############################################################
  # NAME
  #  PX_PO_RCV
  # SYNOPSIS
  #  proc PX_PO_RCV
  # DESCRIPTION
  #  1、采购订单获取逻辑，取当月月底前包含这个品种的采购订单的最大订单号，验证订单行“需要日期”
  #  或“承诺日期”<=月底最后一天
	#  2、传入的成品编码id 要是净水的id
	#  3、传入的仓库和货位，必须是接收的仓库和货位，不是的话需要调用程序前处理；
	#  4、采购退货，需要依据传入的 pxid+lotid+itemid 信息 在表 CUX_PX_RCV_B 找出接收类型的记录，
	#  来获取接收仓库接收号等相关信息
  ###############################################################*/       
  procedure PX_PO_RCV(R_PO_RCV_IN IN CUX_DEVELOP_NS_PO_PKG.R_PO_RCV
                  ,V_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG OUT varchar2--错误信息返回
    ) IS
		
		l_lot_no                   VARCHAR2(240);
		l_sublot_no                VARCHAR2(240);
    cursor C IS
	 --改成直接获取，po_header_id 和po_line_id 记录
    --游标要改:采购订单获取逻辑，取当月月底前包含这个品种的采购订单的最大订单号，验证订单行“需要日期”
    --或“承诺日期”<=月底最后一天
       SELECT DISTINCT H.PO_HEADER_ID,L.PO_LINE_ID,H.SEGMENT1
 /* ,LL.QUANTITY , LL.QUANTITY_RECEIVED,L.UNIT_MEAS_LOOKUP_CODE,
  GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                                                                            0,
                                                                            LL.QUANTITY -LL.QUANTITY_RECEIVED,
                                                                             L.UNIT_MEAS_LOOKUP_CODE,
                                                                            I.ITEM_UM,
                                                                            0),
  I.ITEM_UM,I.ITEM_UM2,I.ITEM_NO,I.ITEM_DESC1,
  L.**/
  FROM PO_HEADERS_ALL        H,
       PO_LINES_ALL          L,
       PO_LINE_LOCATIONS_ALL LL,
       --PO_DISTRIBUTIONS_ALL  D,
       MTL_SYSTEM_ITEMS_B B,
       GL_PLCY_MST        G,
       IC_ITEM_MST_B  I
       ,ORG_ORGANIZATION_DEFINITIONS O
 WHERE H.PO_HEADER_ID = L.PO_HEADER_ID
   AND H.PO_HEADER_ID = LL.PO_HEADER_ID
   AND L.PO_LINE_ID = LL.PO_LINE_ID
      --AND L.PO_LINE_ID = D.PO_LINE_ID
      --AND L.PO_HEADER_ID = D.PO_HEADER_ID
   AND L.ITEM_ID = B.INVENTORY_ITEM_ID
   AND LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
   AND H.ORG_ID = G.ORG_ID
      --AND ll.quantity_received>0
      -- and H.PO_HEADER_ID = 92870--L_PO_HEADER_ID
      -- AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
   AND B.SEGMENT1 = I.ITEM_NO
   AND LL.SHIP_TO_ORGANIZATION_ID=O.ORGANIZATION_ID
      
      --AND B.ORGANIZATION_ID=85
      
   AND L.CANCEL_FLAG <> 'Y'
   AND H.TYPE_LOOKUP_CODE = 'STANDARD'
   AND H.AUTHORIZATION_STATUS = 'APPROVED'
      
  -- AND H.LAST_UPDATE_DATE >NVL(L_REQ_DATE,L_INI_REQ_DATE)
   
   --AND H.PO_HEADER_ID=CR_PO_RCV.C_IN_ERPID--L_PO_HEADER_ID--92906
   --AND LL.SHIP_TO_ORGANIZATION_ID=L_SHIP_TO_ORGANIZATION_ID--116
   AND G.CO_CODE = R_PO_RCV_IN.P_TO_CO_CODE--'GF' --'NS'
   --AND H.SEGMENT1=9
   
   AND  SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1)=R_PO_RCV_IN.P_WHSE_CODE
   --AND L.PO_LINE_ID = CR_PO_RCV.C_IN_ERPOrder
   AND nvl(L.ATTRIBUTE5,NVL(l_sublot_no,-1)) =NVL(l_sublot_no,-1)--SUBLOT_NO--采购订单行 弹性域记录的 子批次
   AND i.item_id=R_PO_RCV_IN.P_ITEM_ID
   --and LL.QUANTITY - LL.QUANTITY_RECEIVED-&P_QTY>0--未接收数量>实际接收数量 才能产生事务
   AND GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                                                                            0,
                                                                            LL.QUANTITY -LL.QUANTITY_RECEIVED,
                                                                             L.UNIT_MEAS_LOOKUP_CODE,
                                                                            I.ITEM_UM,
                                                                            0)-R_PO_RCV_IN.P_QTY>0--未接收数量>实际接收数量 才能产生事务
   
   AND NVL(LL.NEED_BY_DATE, NVL(LL.PROMISED_DATE,SYSDATE))<=TO_DATE(TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')||'235959','YYYY-MM-DD HH24:MI:SS')
   
   AND  H.SEGMENT1=(SELECT MAX(H.SEGMENT1)
  FROM PO_HEADERS_ALL        H,
       PO_LINES_ALL          L,
       PO_LINE_LOCATIONS_ALL LL,
       --PO_DISTRIBUTIONS_ALL  D,
       MTL_SYSTEM_ITEMS_B B,
       GL_PLCY_MST        G,
       IC_ITEM_MST_B  I
       ,ORG_ORGANIZATION_DEFINITIONS O
 WHERE H.PO_HEADER_ID = L.PO_HEADER_ID
   AND H.PO_HEADER_ID = LL.PO_HEADER_ID
   AND L.PO_LINE_ID = LL.PO_LINE_ID
      --AND L.PO_LINE_ID = D.PO_LINE_ID
      --AND L.PO_HEADER_ID = D.PO_HEADER_ID
   AND L.ITEM_ID = B.INVENTORY_ITEM_ID
   AND LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
   AND H.ORG_ID = G.ORG_ID
      --AND ll.quantity_received>0
      -- and H.PO_HEADER_ID = 92870--L_PO_HEADER_ID
      -- AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
   AND B.SEGMENT1 = I.ITEM_NO
   AND LL.SHIP_TO_ORGANIZATION_ID=O.ORGANIZATION_ID
      
      --AND B.ORGANIZATION_ID=85
      
   AND L.CANCEL_FLAG <> 'Y'
   AND H.TYPE_LOOKUP_CODE = 'STANDARD'
   AND H.AUTHORIZATION_STATUS = 'APPROVED'
      
  -- AND H.LAST_UPDATE_DATE >NVL(L_REQ_DATE,L_INI_REQ_DATE)
   
   --AND H.PO_HEADER_ID=CR_PO_RCV.C_IN_ERPID--L_PO_HEADER_ID--92906
   --AND LL.SHIP_TO_ORGANIZATION_ID=L_SHIP_TO_ORGANIZATION_ID--116
   AND G.CO_CODE = R_PO_RCV_IN.P_TO_CO_CODE--'GF' --'NS'
   --AND H.SEGMENT1=9
   
   AND  SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1)=R_PO_RCV_IN.P_WHSE_CODE
   --AND L.PO_LINE_ID = CR_PO_RCV.C_IN_ERPOrder
   AND nvl(L.ATTRIBUTE5,NVL(l_sublot_no,-1)) =NVL(l_sublot_no,-1)--SUBLOT_NO--采购订单行 弹性域记录的 子批次
   AND i.item_id=R_PO_RCV_IN.P_ITEM_ID
   --and LL.QUANTITY - LL.QUANTITY_RECEIVED-&P_QTY>0--未接收数量>实际接收数量 才能产生事务
   AND GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                                                                            0,
                                                                            LL.QUANTITY -LL.QUANTITY_RECEIVED,
                                                                             L.UNIT_MEAS_LOOKUP_CODE,
                                                                            I.ITEM_UM,
                                                                            0)-R_PO_RCV_IN.P_QTY>0--未接收数量>实际接收数量 才能产生事务
   
   AND NVL(LL.NEED_BY_DATE, NVL(LL.PROMISED_DATE,SYSDATE))<=TO_DATE(TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')||'235959','YYYY-MM-DD HH24:MI:SS')
	
	 )
  
         ;
   
    CR            C%rowtype;
    V_PHASE       varchar2(100);
    V_STATUS      varchar2(100);
    V_DEV_PHASE   varchar2(100);
    V_DEV_STATUS  varchar2(100);
    V_MESSAGE     varchar2(400);
    L_REQUEST_ID  number;
    V_STATUS_CODE varchar2(1);
    V_PHASE_CODE  varchar2(1);
    L_RESP_ID   NUMBER;
    
    L_TRANS                    VARCHAR2(1000);
    L_MSG                      VARCHAR2(4000);
    L_COUNT                    NUMBER:=0;
    L_COUNT_cr                   NUMBER:=0;
    L_ITEM_NO                  VARCHAR2(240);
		l_item_Desc                VARCHAR2(240);
		
		V_RECEIPT_NUM              VARCHAR2(240);
		
		R_PX_RCV  CUX_DEVELOP_NS_OPM_PKG.R_PX_RCV;--PX成品接收退货记录表
  BEGIN
		
	  
     IF R_PO_RCV_IN.P_TO_CO_CODE LIKE 'GF'
      THEN
        L_RESP_ID:=50311;--GF.采购接收--20707;--采购超级用户
    ELSE
      SELECT DISTINCT
       Z.RESPONSIBILITY_ID
       INTO L_RESP_ID
        FROM FND_RESPONSIBILITY_VL Z
       WHERE Z.APPLICATION_ID = 201 --222--401
       AND Z.RESPONSIBILITY_NAME LIKE R_PO_RCV_IN.P_TO_CO_CODE||'%Purchasing Super User%'

      ;
    END IF;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201)
															 ;
															 
    --L_TRANS:='参数有效性校验';
    --------------------------------传入参数校验 start--------------------------------------
    BEGIN
    L_TRANS:='发货方组织检查';
    L_COUNT:=0;
    SELECT COUNT(*)--g.co_code, g.org_id, g.sob_id, g.set_of_books_name,G.OPERATING_UNIT, g.*
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =R_PO_RCV_IN.P_FROM_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：发货方组织检查';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：发货方组织检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='采购接收方组织检查';
    L_COUNT:=0;
    SELECT COUNT(*)--g.co_code, g.org_id, g.sob_id, g.set_of_books_name,G.OPERATING_UNIT, g.*
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =R_PO_RCV_IN.P_TO_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：采购接收方组织检查';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：采购接收方组织检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='类型检查';
    IF NVL(R_PO_RCV_IN.P_TYPE,-1) NOT IN ('D','R')
      THEN
        L_MSG:=L_MSG||' 参数错误：类型检查';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：类型检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='PX_ID检查';
    IF R_PO_RCV_IN.P_PX_ID IS NULL
      THEN
        L_MSG:=L_MSG||' 参数错误：PX_ID不能为空';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：PX_ID不能为空';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='R_PO_RCV_IN.P_ITEM_ID检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：不存在R_PO_RCV_IN.P_ITEM_ID：'||R_PO_RCV_IN.P_ITEM_ID||' 的item； ';
        RAISE err_others;
    END IF;
    
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID
    AND (B.DELETE_MARK=1
    OR B.INACTIVE_IND=1)
    ;
    IF l_count >0
      THEN
        L_MSG:=L_MSG||' 参数错误：此R_PO_RCV_IN.P_ITEM_ID：'||R_PO_RCV_IN.P_ITEM_ID||' 已经被标记为删除或无效； ';
        RAISE err_others;
    END IF;
    
    L_COUNT:=0;
    SELECT B.ITEM_NO,b.item_desc1
    INTO L_ITEM_NO,l_item_desc
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID
    AND (B.DELETE_MARK=0
    OR B.INACTIVE_IND=0)
    --AND b.item_desc1 NOT LIKE '%原浆%'
    ;
    IF L_ITEM_NO LIKE '05-1-1%' AND l_item_desc NOT LIKE '%原浆%'
      THEN
      IF SUBSTR(L_ITEM_NO,INSTR(L_ITEM_NO,'-',-1,2)+1,INSTR(L_ITEM_NO,'-',-1,1)-INSTR(L_ITEM_NO,'-',-1,2)-1)<>'6'--非净水库存
        THEN
        L_MSG:=L_MSG||' 参数错误：此R_PO_RCV_IN.P_ITEM_ID：'||R_PO_RCV_IN.P_ITEM_ID||' 传入的不是净水成品就的item_id； ';
        RAISE err_others;
      END IF;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_ITEM_ID检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='R_PO_RCV_IN.P_LOT_ID 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_LOTS_MST L
    WHERE L.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID
    AND L.LOT_ID=R_PO_RCV_IN.P_LOT_ID
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：不存在 R_PO_RCV_IN.P_ITEM_ID：'||R_PO_RCV_IN.P_ITEM_ID||' , R_PO_RCV_IN.P_LOT_ID：'||R_PO_RCV_IN.P_LOT_ID||'； ';
        RAISE err_others;
		ELSE
			SELECT l.lot_no,l.sublot_no
    INTO l_lot_no,l_sublot_no
    FROM IC_LOTS_MST L
    WHERE L.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID
    AND L.LOT_ID=R_PO_RCV_IN.P_LOT_ID
    ;
    END IF;
       
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_LOT_ID 检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='R_PO_RCV_IN.P_TRANS_DATE 检查';
    --验证 R_PO_RCV_IN.P_TRANS_DATE 采购期间有没有打开，总账期间有没有打开，库存期间有没有打开
    L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM GL_PERIOD_STATUSES P,
       fnd_user           f,
       FND_APPLICATION_VL A,
       GL_SETS_OF_BOOKS_V S
       ,GL_PLCY_MST G
 WHERE p.last_updated_by = f.user_id
   and p.application_id = a.application_id
   and p.set_of_books_id = s.set_of_books_id
   AND G.SOB_ID=S.SET_OF_BOOKS_ID
   
   AND TRUNC(R_PO_RCV_IN.P_TRANS_DATE,'DD') >=P.START_DATE
   AND TRUNC(R_PO_RCV_IN.P_TRANS_DATE,'DD') <=P.END_DATE
   AND G.CO_CODE=R_PO_RCV_IN.P_TO_CO_CODE
   AND A.APPLICATION_SHORT_NAME ='PO'--SQLGL 
   AND p.closing_status='O'
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_TRANS_DATE：'||R_PO_RCV_IN.P_TRANS_DATE||' ,采购期间没打开； ';
        RAISE err_others;
    END IF;
    
    L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM GL_PERIOD_STATUSES P,
       fnd_user           f,
       FND_APPLICATION_VL A,
       GL_SETS_OF_BOOKS_V S
       ,GL_PLCY_MST G
 WHERE p.last_updated_by = f.user_id
   and p.application_id = a.application_id
   and p.set_of_books_id = s.set_of_books_id
   AND G.SOB_ID=S.SET_OF_BOOKS_ID
   
   AND TRUNC(add_months(R_PO_RCV_IN.P_TRANS_DATE,-1),'DD') >=P.START_DATE
   AND TRUNC(add_months(R_PO_RCV_IN.P_TRANS_DATE,-1),'DD') <=P.END_DATE
   AND G.CO_CODE=R_PO_RCV_IN.P_TO_CO_CODE
   AND A.APPLICATION_SHORT_NAME =/*'PO'--*/'SQLGL'
   AND p.closing_status='O'
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_TRANS_DATE：'||R_PO_RCV_IN.P_TRANS_DATE||' ,集成总账期间没打开； ';
        RAISE err_others;
    END IF;
       
    L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM ORG_ACCT_PERIODS_V B, IC_WHSE_MST W,ORG_ORGANIZATION_DEFINITIONS A
 WHERE B.ORGANIZATION_ID = W.MTL_ORGANIZATION_ID
   AND A.ORGANIZATION_ID=B.organization_id
   
   AND W.WHSE_CODE =R_PO_RCV_IN.P_WHSE_CODE
   AND TRUNC(R_PO_RCV_IN.P_TRANS_DATE,'DD') >=B.start_date
   AND TRUNC(R_PO_RCV_IN.P_TRANS_DATE,'DD') <=B.end_date
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_TRANS_DATE：'||R_PO_RCV_IN.P_TRANS_DATE||',R_PO_RCV_IN.P_WHSE_CODE:'||R_PO_RCV_IN.P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
       
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_TRANS_DATE 检查';
      RAISE err_others;
    END;
    
  BEGIN
    L_TRANS:='R_PO_RCV_IN.P_WHSE_CODE 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
     FROM SY_ORGN_MST_VL A, IC_WHSE_MST W,GL_PLCY_MST G
 WHERE A.ORGN_CODE = W.ORGN_CODE
 AND A.CO_CODE=G.CO_CODE
   AND W.DELETE_MARK = 0
   AND A.DELETE_MARK = 0
   AND A.ORGN_CODE <> A.PARENT_ORGN_CODE
   AND A.PARENT_ORGN_CODE NOT LIKE '%LAB%'
   AND A.PARENT_ORGN_CODE NOT LIKE 'JT'
   AND W.WHSE_CODE = R_PO_RCV_IN.P_WHSE_CODE/*
   AND A.PARENT_ORGN_CODE LIKE &PARENT_ORGN_CODE --'GF'
   AND A.CO_CODE LIKE &CO_CODE*/
  ;
    IF L_COUNT<1
      THEN
         L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_WHSE_CODE：'||R_PO_RCV_IN.P_WHSE_CODE||' ,接收仓库无效或不存在； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 R_PO_RCV_IN.P_WHSE_CODE 检查';
      RAISE err_others;
    END;    
    
  BEGIN
    L_TRANS:='R_PO_RCV_IN.P_LOCATION 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
     from ic_loct_mst l, ic_whse_mst w
 where l.whse_code = w.whse_code
 AND W.WHSE_CODE =R_PO_RCV_IN.P_WHSE_CODE
 AND L.LOCATION =R_PO_RCV_IN.P_LOCATION
 AND w.delete_mark=0
 AND l.delete_mark=0
  ;
    IF L_COUNT<1
      THEN
         L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_LOCATION：'||R_PO_RCV_IN.P_LOCATION||',R_PO_RCV_IN.P_WHSE_CODE:'||R_PO_RCV_IN.P_WHSE_CODE||' ,接收货位无效或不存在； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 R_PO_RCV_IN.P_LOCATION 检查';
      RAISE err_others;
    END;  
    
  BEGIN
    L_TRANS:='R_PO_RCV_IN.P_QTY 检查';
    IF R_PO_RCV_IN.P_QTY<=0
      THEN
         L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_QTY：'||R_PO_RCV_IN.P_QTY||' ,数量请填正数； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 R_PO_RCV_IN.P_QTY 检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='R_PO_RCV_IN.p_um 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID
    AND B.ITEM_UM=R_PO_RCV_IN.p_um
    AND (B.DELETE_MARK=0
    OR B.INACTIVE_IND=0)
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：此R_PO_RCV_IN.P_ITEM_ID：'||R_PO_RCV_IN.P_ITEM_ID||',R_PO_RCV_IN.p_um:'||R_PO_RCV_IN.p_um||' 不是第一单位，请传入第一单位数量和第一单位； ';
        RAISE err_others;
    END IF;
   
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.p_um 检查';
      RAISE err_others;
    END;
                  
    --R_PO_RCV_IN.P_USER_NAME 不为空的时候，要获取 user_ID 到 P_USER_ID 做初始化
    --空的时候，默认用户 CY_ZCM
    --要验证接受用户，订单的接收仓库，的用户组织，仓管员权限，是否已经有，没的话报错
    --订单的接收组织和传入参数的接收仓库组织是否 一致 不一致报错
    BEGIN
    L_TRANS:='R_PO_RCV_IN.P_USER_NAME 检查';
    IF R_PO_RCV_IN.P_USER_NAME IS NOT NULL
      THEN
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM FND_USER F
WHERE F.USER_NAME = R_PO_RCV_IN.P_USER_NAME
--AND F.USER_ID LIKE &USER_ID
AND NVL(F.END_DATE,SYSDATE+1)>SYSDATE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_USER_NAME：'||R_PO_RCV_IN.P_USER_NAME||' ,用户名不存在或已经被无效； ';
        RAISE err_others;
    END IF;
    
    SELECT F.USER_ID
    INTO P_USER_ID
     FROM FND_USER F
WHERE F.USER_NAME = R_PO_RCV_IN.P_USER_NAME
--AND F.USER_ID LIKE &USER_ID
AND NVL(F.END_DATE,SYSDATE+1)>SYSDATE
    ;
		ELSE
			P_USER_ID:=P_USER_ID_CP;
    
    END IF;
    
    --用户组织检查
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM SY_ORGN_USR A,FND_USER F,IC_WHSE_MST W
WHERE A.USER_ID=F.USER_ID
AND A.ORGN_CODE=W.ORGN_CODE
AND A.USER_ID=P_USER_ID
AND W.WHSE_CODE=R_PO_RCV_IN.P_WHSE_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_ID：'||P_USER_ID||',R_PO_RCV_IN.P_WHSE_CODE:'|| R_PO_RCV_IN.P_WHSE_CODE||' ,用户没有分配接收仓库的用户组织； ';
        RAISE err_others;
    END IF;
    
    --仓管员权限检查
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM CUX_req_whse_manager_v A
WHERE A.WHSE_CODE=R_PO_RCV_IN.P_WHSE_CODE
AND A.USER_ID=P_USER_ID
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_ID：'||P_USER_ID||',R_PO_RCV_IN.P_WHSE_CODE:'|| R_PO_RCV_IN.P_WHSE_CODE||' ,用户没有分配接收仓库的仓管员权限； ';
        RAISE err_others;
    END IF;
    
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_USER_NAME 检查';
      RAISE err_others;
    END;
    
    /*--追加格式
    BEGIN
    L_TRANS:='XXXX 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =R_PO_RCV_IN.P_TO_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：R_PO_RCV_IN.P_TRANS_DATE：'||R_PO_RCV_IN.P_TRANS_DATE||',R_PO_RCV_IN.P_WHSE_CODE:'||R_PO_RCV_IN.P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：XXXX 检查';
      RAISE err_others;
    END;
    */
    --------------------------------传入参数校验 END--------------------------------------
    
     IF R_PO_RCV_IN.P_TO_CO_CODE LIKE 'GF'
      THEN
        L_RESP_ID:=50311;--GF.采购接收--20707;--采购超级用户
    ELSE
      SELECT DISTINCT
       Z.RESPONSIBILITY_ID
       INTO L_RESP_ID
        FROM FND_RESPONSIBILITY_VL Z
       WHERE Z.APPLICATION_ID = 201 --222--401
       AND Z.RESPONSIBILITY_NAME LIKE R_PO_RCV_IN.P_TO_CO_CODE||'%Purchasing Super User%'

      ;
    END IF;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201)
                         ;
    IF R_PO_RCV_IN.P_TYPE = 'D'
      THEN  
      L_COUNT_cr:=0;																			
    for CR in C
    loop
        MSG_OUTPUT('开始接收订单' || ':' || CR.SEGMENT1);
      L_COUNT_cr:=L_COUNT_cr+1;
      WMS_CREATE_PO_RCV(R_PO_RCV_IN.P_TO_CO_CODE--L_CO_CODE--P_CO_CODE IN VARCHAR2,
                          ,CR.PO_HEADER_ID--P_PO_HEADER_ID IN number
                  ,CR.PO_LINE_ID--    IN NUMBER
                  ,R_PO_RCV_IN.P_ITEM_ID --   IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,l_LOT_NO  --   IN VARCHAR2
                  ,l_SUBLOT_NO --    IN VARCHAR2
                  ,R_PO_RCV_IN.P_TRANS_DATE-- IN DATE--采购接收或退货事务时间
                  ,R_PO_RCV_IN.P_WHSE_CODE--  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,R_PO_RCV_IN.P_LOCATION --  IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,R_PO_RCV_IN.P_QTY  --      IN NUMBER--接收数量,退货数量，第一单位数量
                  ,R_PO_RCV_IN.p_um  --      IN VARCHAR2--接收数量对应的单位
                  ,R_PO_RCV_IN.P_REMARK --    IN VARCHAR2--备注
                  ,P_USER_ID -- IN NUMBER--
                  ,R_PO_RCV_IN.P_REMARK--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,'PX AUTO RCV'--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS --OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_MESSAGE--V_ERROR_MSG OUT varchar2--错误信息返回
                  ,V_RECEIPT_NUM -- IN OUT NUMBER--D:采购接收事，返回接收号；R：采购退货，要求传入接收号；
                          );
                      
      IF V_RETURN_STATUS not in ('S')
      THEN
         L_MSG:=L_MSG||' ；采购接收接口报错：'||V_MESSAGE;
        raise ERR_OTHERS;
      ELSE
				 MSG_OUTPUT('接收号' || ':' || V_RECEIPT_NUM);
        L_MSG:=L_MSG||'采购接收接口写入完成；';
      end if;										
			                    
      MSG_OUTPUT('完成接收订单' || ':' || CR.SEGMENT1);
    end loop;
		
		IF L_COUNT_cr=0
			THEN
        L_MSG:=L_MSG||' 采购接收游标没有数据；没有找到符合的采购订单；';
      RAISE err_others;
    
		END IF;
		
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RVCTP', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,
                                               'BATCH',
                                               null,
                                               CHR(0));

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购接收请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购接收请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
		
		--INSERT CUX_PX_RCV_B 记录接收号等信息
		--R_PX_RCV
		BEGIN
		L_TRANS:='PX采购接收信息 写入 px中间表 CUX_PX_RCV_B ';
		--R_PX_RCV.px_rcv_id:=px_rcv_id ;
		R_PX_RCV.px_id:=R_PO_RCV_IN.P_PX_ID;--px_id ;
		R_PX_RCV.px_line_id:=R_PO_RCV_IN.P_PX_LINE_ID;--px_line_id ;
		R_PX_RCV.form_co_code:=R_PO_RCV_IN.P_FROM_CO_CODE;--form_co_code ;
		R_PX_RCV.to_co_code:=R_PO_RCV_IN.P_TO_CO_CODE;--to_co_code ;
		R_PX_RCV.item_id:=R_PO_RCV_IN.P_ITEM_ID;--item_id ;
		R_PX_RCV.lot_id:=R_PO_RCV_IN.P_LOT_ID;--lot_id ;
		R_PX_RCV.rcv_trans_date:=R_PO_RCV_IN.P_TRANS_DATE;--rcv_trans_date ;
		R_PX_RCV.whse_code:=R_PO_RCV_IN.P_WHSE_CODE;--whse_code ;
		R_PX_RCV.location:=R_PO_RCV_IN.P_LOCATION;--location ;
		R_PX_RCV.rcv_qty1:=R_PO_RCV_IN.P_QTY;--rcv_qty1 ;
		R_PX_RCV.remark:=R_PO_RCV_IN.P_REMARK;--remark ;
		R_PX_RCV.rcv_no:=V_RECEIPT_NUM;--rcv_no ;
		--R_PX_RCV.creation_date:=creation_date ;
		R_PX_RCV.created_by:=P_USER_ID;--created_by ;
		--R_PX_RCV.last_update_date:=last_update_date ;
		R_PX_RCV.last_updated_by:=P_USER_ID;--last_updated_by ;
		--R_PX_RCV.last_update_login:=last_update_login ;
		R_PX_RCV.rcv_type:=R_PO_RCV_IN.P_TYPE;--'D';--rcv_type ;--D R
		R_PX_RCV.SO_NAME_ID:=R_PO_RCV_IN.P_SO_NAME_ID;
    
		V_RETURN_STATUS :=NULL;
    V_MESSAGE       :=NULL;
		CUX_DEVELOP_NS_OPM_PKG.insert_PX_RCV_HISTORY(r_PX_RCV,
                    V_RETURN_STATUS ,
                    V_MESSAGE     );
	 IF V_RETURN_STATUS <>'S'
		 THEN
			 L_MSG:=L_MSG||' '||V_MESSAGE||' 写入 px中间表 CUX_PX_RCV_B 异常!';
      RAISE err_others;
		 END IF;
		 
		 COMMIT;
		 
		 EXCEPTION
      when others THEN
        L_MSG:=L_MSG||' 写入 px中间表 CUX_PX_RCV_B 异常!';
      RAISE err_others;
    END;
    
    ELSIF R_PO_RCV_IN.P_TYPE = 'R'
      THEN  
				--增加接收号的查找程序，依据传入参数查找对应的接收号
				V_RECEIPT_NUM:=NULL;
				
		BEGIN
    L_TRANS:='从px中间表 CUX_PX_RCV_B 获取接收号 ';
    SELECT DISTINCT B.RCV_NO
		 INTO V_RECEIPT_NUM
		FROM CUX_PX_RCV_B B
		WHERE B.PX_ID=R_PO_RCV_IN.P_PX_ID  
		AND B.ITEM_ID=R_PO_RCV_IN.P_ITEM_ID 
		AND B.LOT_ID=R_PO_RCV_IN.P_LOT_ID  
		AND b.so_name_id=R_PO_RCV_IN.p_so_name_id
		AND B.RCV_TYPE='D'
		AND B.TO_CO_CODE=R_PO_RCV_IN.P_TO_CO_CODE
		AND B.RCV_NO IS NOT NULL
		;
     
     EXCEPTION
      when others THEN
        L_MSG:=L_MSG||' 从px中间表 CUX_PX_RCV_B 获取接收号 异常!';
      RAISE err_others;
    END;
				 MSG_OUTPUT('退货接收号' || ':' || V_RECEIPT_NUM);
				 
        CREATE_PO_RETURN(R_PO_RCV_IN.P_WHSE_CODE--'PX21'--R_PO_RCV_IN.P_WHSE_CODE  
                          ,V_RECEIPT_NUM--'71567'--P_RCV_NO  
                          ,R_PO_RCV_IN.P_ITEM_ID  
                          ,R_PO_RCV_IN.P_LOT_ID  
                          ,R_PO_RCV_IN.P_TRANS_DATE--采购接收或退货事务时间
                          ,R_PO_RCV_IN.P_WHSE_CODE  --接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,R_PO_RCV_IN.P_LOCATION  --接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,R_PO_RCV_IN.P_QTY        --接收数量,退货数量，第一单位数量
                          ,R_PO_RCV_IN.p_um          --接收数量对应的单位
                          ,R_PO_RCV_IN.P_REMARK     --备注
                  ,R_PO_RCV_IN.P_REMARK--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,'PX AUTO RET'--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                          ,V_RETURN_STATUS --返回状态：S-正常完成，E-异常终止
                          ,V_MESSAGE --错误信息返回                          
                          )
                          ;
        
      if V_RETURN_STATUS not in ('S')
      THEN
         L_MSG:=L_MSG||' ；采购退货接口报错：'||V_MESSAGE;
        raise ERR_OTHERS;
      ELSE
        L_MSG:=L_MSG||'采购退货接口写入完成；';
      end if;
      
        FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => 20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RVCTP', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,
                                               'BATCH',
                                               null,
                                               CHR(0));

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
    
		--INSERT CUX_PX_RCV_B 记录退货信息
    --R_PX_RCV
    BEGIN
    L_TRANS:='PX采购退货信息 写入 px中间表 CUX_PX_RCV_B ';
    --R_PX_RCV.px_rcv_id:=px_rcv_id ;
    R_PX_RCV.px_id:=R_PO_RCV_IN.P_PX_ID;--px_id ;
    R_PX_RCV.px_line_id:=R_PO_RCV_IN.P_PX_LINE_ID;--px_line_id ;
    R_PX_RCV.form_co_code:=R_PO_RCV_IN.P_FROM_CO_CODE;--form_co_code ;
    R_PX_RCV.to_co_code:=R_PO_RCV_IN.P_TO_CO_CODE;--to_co_code ;
    R_PX_RCV.item_id:=R_PO_RCV_IN.P_ITEM_ID;--item_id ;
    R_PX_RCV.lot_id:=R_PO_RCV_IN.P_LOT_ID;--lot_id ;
    R_PX_RCV.rcv_trans_date:=R_PO_RCV_IN.P_TRANS_DATE;--rcv_trans_date ;
    R_PX_RCV.whse_code:=R_PO_RCV_IN.P_WHSE_CODE;--whse_code ;
    R_PX_RCV.location:=R_PO_RCV_IN.P_LOCATION;--location ;
    R_PX_RCV.rcv_qty1:=R_PO_RCV_IN.P_QTY;--rcv_qty1 ;
    R_PX_RCV.remark:=R_PO_RCV_IN.P_REMARK;--remark ;
    R_PX_RCV.rcv_no:=V_RECEIPT_NUM;--rcv_no ;
    --R_PX_RCV.creation_date:=creation_date ;
    R_PX_RCV.created_by:=P_USER_ID;--created_by ;
    --R_PX_RCV.last_update_date:=last_update_date ;
    R_PX_RCV.last_updated_by:=P_USER_ID;--last_updated_by ;
    --R_PX_RCV.last_update_login:=last_update_login ;
    R_PX_RCV.rcv_type:=R_PO_RCV_IN.P_TYPE;--'D';--rcv_type ;--D R
		R_PX_RCV.SO_NAME_ID:=R_PO_RCV_IN.P_SO_NAME_ID;
    
    V_RETURN_STATUS :=NULL;
    V_MESSAGE       :=NULL;
    CUX_DEVELOP_NS_OPM_PKG.insert_PX_RCV_HISTORY(r_PX_RCV,
                    V_RETURN_STATUS ,
                    V_MESSAGE     );
   IF V_RETURN_STATUS <>'S'
     THEN
       L_MSG:=L_MSG||' '||V_MESSAGE||' 写入 px中间表 CUX_PX_RCV_B 异常!';
      RAISE err_others;
     END IF;
     
     COMMIT;
     
     EXCEPTION
      when others THEN
        L_MSG:=L_MSG||' 写入 px中间表 CUX_PX_RCV_B 异常!';
      RAISE err_others;
    END;
    
    END IF;
    
    V_RETURN_STATUS := 'S';
       L_MSG:=L_MSG||'采购接口事务产生完成';
      -- L_MSG:=L_MSG||'传入参数：L_CO_CODE: '||l_co_code||',l_period_code: '||l_period_code;--||',l_type: '||l_type;
    V_ERROR_MSG:=L_MSG;
      /* FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================result========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||V_ERROR_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'V_RETURN_STATUS： '||V_RETURN_STATUS);--日志输出
        */
        MSG_OUTPUT('================result========================');
        MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
       /* MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,256,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,500,255));
        
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,756,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1000,255));
        */
      exception
      WHEN err_others THEN
        V_RETURN_STATUS := 'E';
       L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出';--' 过程异常退出,主体传入参数：R_PO_RCV_IN.P_FROM_CO_CODE: '||R_PO_RCV_IN.P_FROM_CO_CODE||',R_PO_RCV_IN.P_TO_CO_CODE: '||R_PO_RCV_IN.P_TO_CO_CODE||',R_PO_RCV_IN.P_TYPE: '||R_PO_RCV_IN.P_TYPE||',R_PO_RCV_IN.P_PX_ID: '||R_PO_RCV_IN.P_PX_ID||',R_PO_RCV_IN.P_ITEM_ID: '||R_PO_RCV_IN.P_ITEM_ID||',R_PO_RCV_IN.P_LOT_ID: '||R_PO_RCV_IN.P_LOT_ID||',R_PO_RCV_IN.P_TRANS_DATE: '||R_PO_RCV_IN.P_TRANS_DATE||',R_PO_RCV_IN.P_WHSE_CODE: '||R_PO_RCV_IN.P_WHSE_CODE||',R_PO_RCV_IN.P_LOCATION: '||R_PO_RCV_IN.P_LOCATION||',R_PO_RCV_IN.P_QTY: '||R_PO_RCV_IN.P_QTY||',R_PO_RCV_IN.p_um: '||R_PO_RCV_IN.p_um||',R_PO_RCV_IN.P_REMARK: '||R_PO_RCV_IN.P_REMARK||',R_PO_RCV_IN.P_USER_NAME: '||R_PO_RCV_IN.P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
        /*MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,256,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,500,255));
        
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,756,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1000,255));*/
        /*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||V_ERROR_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'V_RETURN_STATUS： '||V_RETURN_STATUS);--日志输出
        */
      when others then
       V_RETURN_STATUS := 'E';
        V_ERROR_MSG:=L_MSG||';'||L_TRANS||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
       /* MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,256,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,500,255));
        
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,756,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1000,255));
        */
        /*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||V_ERROR_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'V_RETURN_STATUS： '||V_RETURN_STATUS);--日志输出
        */
  end;


  function GET_RECEIPT_NUM(P_ORGANIZATION_ID in number) return varchar2 is
    L_COUNT       number;
    L_RECEIPT_NUM varchar2(100);
    pragma autonomous_transaction;
  begin
    begin
      select (NEXT_RECEIPT_NUM + 1)
        into L_RECEIPT_NUM
        from RCV_PARAMETERS
       where ORGANIZATION_ID = P_ORGANIZATION_ID
         for update of NEXT_RECEIPT_NUM;
      loop
        select count(*)
          into L_COUNT
          from RCV_SHIPMENT_HEADERS
         where RECEIPT_NUM = L_RECEIPT_NUM
           and SHIP_TO_ORG_ID = P_ORGANIZATION_ID;
        if L_COUNT = 0
        then
          update RCV_PARAMETERS
             set NEXT_RECEIPT_NUM = L_RECEIPT_NUM
           where ORGANIZATION_ID = P_ORGANIZATION_ID;
          exit;
        else
          L_RECEIPT_NUM := TO_CHAR(TO_NUMBER(L_RECEIPT_NUM) + 1);
        end if;
      end loop;
      commit;
      return L_RECEIPT_NUM;
    exception
      when others then
        rollback;
        return null;
    end;
  end;

  procedure CREATE_RCV_HEADER(P_CO_CODE        IN VARCHAR2,
                              P_ORG_ID         in number,
                              P_PO_HEADER_ID   in number,
                              P_SHIP_HEADER_ID out number,
                              P_GROUP_ID       out number,
                              P_STATUS         out varchar2
                              ,P_RECEIPT_NUM   OUT varchar2--D:采购接收事，返回接收号；
															) is

    X_HEADER_RECORD RCV_SHIPMENT_HEADER_SV.HEADERRECTYPE;

    L_CUR_MFG_ORG_ID number := P_ORG_ID; --Current Inv Organization
    L_USER_ID        number := P_USER_ID; --User ID?Sysadmin
    L_RESP_ID        NUMBER;
		
		
		L_TRANS                    VARCHAR2(1000);
		V_ERROR_MSG                VARCHAR2(4000);
		V_RETURN_STATUS            VARCHAR2(10);

  begin
    BEGIN
			L_TRANS:='PO_HEADER_ID: '||P_PO_HEADER_ID||';获取供应商信息; ';
      select H.VENDOR_ID,
             H.VENDOR_SITE_ID
        into X_HEADER_RECORD.HEADER_RECORD.VENDOR_ID,
             X_HEADER_RECORD.HEADER_RECORD.VENDOR_SITE_ID
        from PO_HEADERS_ALL H
       where H.PO_HEADER_ID = P_PO_HEADER_ID;
    exception
      when others then
        MSG_OUTPUT('PO_HEADER_ID' || ':' || P_PO_HEADER_ID || ',' ||
                             '查找供应商信息错误.');
				V_ERROR_MSG:='获取供应商信息 异常；';
        raise ERR_OTHERS;
    end;

    --Login initialize
   /* FND_GLOBAL.APPS_INITIALIZE(USER_ID      => L_USER_ID,
                               RESP_ID      => 51910,
                               RESP_APPL_ID => 401);*/
   /* FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID,
                               RESP_ID      => 20707,
                               RESP_APPL_ID => 201);*/
   IF P_CO_CODE LIKE 'GF'
      THEN
        L_RESP_ID:=50311;--GF.采购接收--20707;--采购超级用户
    ELSE
      SELECT DISTINCT
       Z.RESPONSIBILITY_ID
       INTO L_RESP_ID
        FROM FND_RESPONSIBILITY_VL Z
       WHERE Z.APPLICATION_ID = 201 --222--401
       AND Z.RESPONSIBILITY_NAME LIKE P_CO_CODE||'%Purchasing Super User%'

      ;
    END IF;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201)
                               ;


    select PO.RCV_HEADERS_INTERFACE_S.nextval
      into X_HEADER_RECORD.HEADER_RECORD.HEADER_INTERFACE_ID
      from DUAL;
    select PO.RCV_INTERFACE_GROUPS_S.nextval
      into X_HEADER_RECORD.HEADER_RECORD.GROUP_ID
      from DUAL;

    X_HEADER_RECORD.HEADER_RECORD.PROCESSING_STATUS_CODE := 'PENDING';
    X_HEADER_RECORD.HEADER_RECORD.RECEIPT_SOURCE_CODE    := 'VENDOR';
    X_HEADER_RECORD.HEADER_RECORD.TRANSACTION_TYPE       := 'NEW';
    X_HEADER_RECORD.HEADER_RECORD.AUTO_TRANSACT_CODE     := 'RECEIVE';

    X_HEADER_RECORD.HEADER_RECORD.EXPECTED_RECEIPT_DATE   := sysdate;
    X_HEADER_RECORD.HEADER_RECORD.VALIDATION_FLAG         := 'Y';
    X_HEADER_RECORD.HEADER_RECORD.SHIP_TO_ORGANIZATION_ID := L_CUR_MFG_ORG_ID;

    X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM := null; --Automatic Number

    --Process Receipt Num
    select DECODE(USER_DEFINED_RECEIPT_NUM_CODE,
                  'AUTOMATIC',
                  X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM,
                  X_HEADER_RECORD.HEADER_RECORD.RECEIPT_HEADER_ID)
      into X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM
      from RCV_PARAMETERS
     where ORGANIZATION_ID =
           X_HEADER_RECORD.HEADER_RECORD.SHIP_TO_ORGANIZATION_ID;

    if X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM is null
    then
      X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM := GET_RECEIPT_NUM(P_ORGANIZATION_ID => X_HEADER_RECORD.HEADER_RECORD.SHIP_TO_ORGANIZATION_ID);
    end if;
		
		--P_RECEIPT_NUM:=X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM ;--返回接收号

    BEGIN
			L_TRANS:='CREATE_SHIPMENT_HEADER; ';
    --Initiate error record
    X_HEADER_RECORD.ERROR_RECORD.ERROR_STATUS  := 'S';
    X_HEADER_RECORD.ERROR_RECORD.ERROR_MESSAGE := null;
		
    BEGIN
    --Invoke API
    RCV_SHIPMENT_HEADER_SV.CREATE_SHIPMENT_HEADER(X_HEADER_RECORD => X_HEADER_RECORD);
    EXCEPTION
          when others THEN
          V_ERROR_MSG := 'CREATE_SHIPMENT_HEADER  异常';
          RAISE ERR_OTHERS;
        END;
    --Result
    if X_HEADER_RECORD.ERROR_RECORD.ERROR_STATUS in ('S', 'W')
    then
      MSG_OUTPUT('Success.');
      MSG_OUTPUT('Receipt Number: ' ||
                           X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM);
      MSG_OUTPUT('Receipt Header ID: ' ||
                           X_HEADER_RECORD.HEADER_RECORD.RECEIPT_HEADER_ID);
      P_STATUS         := X_HEADER_RECORD.ERROR_RECORD.ERROR_STATUS;
      P_SHIP_HEADER_ID := X_HEADER_RECORD.HEADER_RECORD.RECEIPT_HEADER_ID;
      P_GROUP_ID       := X_HEADER_RECORD.HEADER_RECORD.GROUP_ID;
			
		P_RECEIPT_NUM:=X_HEADER_RECORD.HEADER_RECORD.RECEIPT_NUM ;--返回接收号
		
    else
      MSG_OUTPUT('Error Status:' ||
                           X_HEADER_RECORD.ERROR_RECORD.ERROR_STATUS);
      MSG_OUTPUT('Error Message:' ||
                           X_HEADER_RECORD.ERROR_RECORD.ERROR_MESSAGE);
			
			V_ERROR_MSG:='CREATE_RCV_HEADER 异常:'||X_HEADER_RECORD.ERROR_RECORD.ERROR_MESSAGE;
    end if;
		
		END;
  
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
			P_STATUS:=V_RETURN_STATUS;
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      /*L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出,主体传入参数：P_FROM_CO_CODE: '||P_FROM_CO_CODE||',P_TO_CO_CODE: '||P_TO_CO_CODE||',P_TYPE: '||P_TYPE||',P_PX_ID: '||P_PX_ID||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
      */  
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
			P_STATUS:=V_RETURN_STATUS;
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
			P_STATUS:=V_RETURN_STATUS;
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
    when others THEN
      V_RETURN_STATUS := 'E';
			P_STATUS:=V_RETURN_STATUS;
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
  END;
	
	/*===================PX 成品采购接收&退货自动产生事务程序 END==================*/
	
	/*===================WMS PO 接口 START==================*/

  /*###############################################################
  # NAME
  #  WMS_CREATE_PO_RCV
  # SYNOPSIS
  #  proc WMS_CREATE_PO_RCV
  # DESCRIPTION
  #  1、采购接收，接口程序 
  ###############################################################*/       
procedure WMS_CREATE_PO_RCV(P_CO_CODE IN VARCHAR2,
                          P_PO_HEADER_ID IN number
                  ,P_PO_LINE_ID    IN NUMBER
                  ,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,P_LOT_NO     IN VARCHAR2
                  ,P_SUBLOT_NO     IN VARCHAR2
                  ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  ,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                  ,p_um         IN VARCHAR2--接收数量对应的单位
                  ,P_REMARK     IN VARCHAR2--备注
                  ,P_USER_ID  IN NUMBER--
                  ,p_vendor_lot_num IN VARCHAR2--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT IN VARCHAR2--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG OUT varchar2--错误信息返回
                  ,V_RECEIPT_NUM   OUT varchar2--D:采购接收事，返回接收号；R：采购退货，要求传入接收号；
                          ) is
    L_LOT_ID         number;
    L_IFACE_RCV_REC  PO.RCV_TRANSACTIONS_INTERFACE%rowtype;
    L_IFACE_LOT      PO.RCV_LOTS_INTERFACE%rowtype;
    mtl_transaction_lots_interfac      mtl_transaction_lots_interface%rowtype;
    V_COUNT          number;
    L_OPM_ITEM_ID    number;
    L_CUR_MFG_ORG_ID number; --Current Inv Organization

    L_SHIP_HEADER_ID number;
    L_GROUP_ID       number;
    L_STATUS         varchar2(2);
    L_LOT_CTR        number;
    L_SUB_CTR        number;
    L_SHIPVEND_ID    number;
    L_DOC_DATE       date;
    L_QC_GRADE       varchar2(100);
    L_LOT_DESC       varchar2(100);
		
		L_TRANS                    VARCHAR2(1000);

    cursor PO_HEAD is
      select distinct H.PO_HEADER_ID,
                      LL.SHIP_TO_ORGANIZATION_ID
        from PO_HEADERS_ALL        H,
             PO_LINES_ALL          L,
             PO_LINE_LOCATIONS_ALL LL
						 ,ORG_ORGANIZATION_DEFINITIONS O
       where H.PO_HEADER_ID = L.PO_HEADER_ID
         and L.PO_LINE_ID = LL.PO_LINE_ID
         and H.TYPE_LOOKUP_CODE = 'STANDARD'
         and H.AUTHORIZATION_STATUS = 'APPROVED'
				 
         and LL.QUANTITY > LL.QUANTITY_RECEIVED
         and H.PO_HEADER_ID = P_PO_HEADER_ID
				 
				 AND LL.SHIP_TO_ORGANIZATION_ID=O.ORGANIZATION_ID
				 AND SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1)=P_WHSE_CODE
         ;

    cursor PO_LINE(L_PO_HEADER_ID number,L_SHIP_TO_ORGANIZATION_ID NUMBER,L_PO_LINE_ID NUMBER) is
      select H.VENDOR_ID,
             H.VENDOR_SITE_ID,
             H.ORG_ID,
             H.CURRENCY_CODE,
             H.AGENT_ID,
             L.PO_LINE_ID,
             L.PO_HEADER_ID,
             LL.LINE_LOCATION_ID,
             D.PO_DISTRIBUTION_ID,
             L.UNIT_MEAS_LOOKUP_CODE,
             LL.SHIP_TO_LOCATION_ID,
             LL.SHIP_TO_ORGANIZATION_ID,
             L.ITEM_ID,
             B.PRIMARY_UNIT_OF_MEASURE,
             B.SECONDARY_UOM_CODE,

             L.ITEM_DESCRIPTION,
             L.CATEGORY_ID,
             --L.QUANTITY QUANTITY,
             LL.QUANTITY - LL.QUANTITY_RECEIVED QUANTITY,
             L.UNIT_PRICE,
             LL.NEED_BY_DATE
        from PO_HEADERS_ALL        H,
             PO_LINES_ALL          L,
             PO_LINE_LOCATIONS_ALL LL,
             PO_DISTRIBUTIONS_ALL  D,
             MTL_SYSTEM_ITEMS_B    B
       where H.PO_HEADER_ID = L.PO_HEADER_ID
         and L.PO_LINE_ID = LL.PO_LINE_ID
         and L.PO_LINE_ID = D.PO_LINE_ID
         and L.PO_HEADER_ID = D.PO_HEADER_ID
         and L.ITEM_ID = B.INVENTORY_ITEM_ID
         and LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
				 
				 AND B.SEGMENT1=(SELECT I.ITEM_NO FROM IC_ITEM_MST_B I WHERE I.ITEM_ID=P_ITEM_ID)
				 
         and LL.QUANTITY > LL.QUANTITY_RECEIVED
				 
         and H.PO_HEADER_ID = L_PO_HEADER_ID
         AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
				 AND L.PO_LINE_ID=L_PO_LINE_ID
         ;
    CR_PO_HEAD PO_HEAD%rowtype;
    CR_PO_LINE PO_LINE%rowtype;
		
  BEGIN
		
    for CR_PO_HEAD in PO_HEAD
    LOOP
			 L_TRANS:='PO_HEADER_ID: '||CR_PO_HEAD.PO_HEADER_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_HEAD.SHIP_TO_ORGANIZATION_ID||';CREATE_RCV_HEADER; ';
      CREATE_RCV_HEADER(P_CO_CODE,
                        P_ORG_ID         => CR_PO_HEAD.SHIP_TO_ORGANIZATION_ID,
                        P_PO_HEADER_ID   => CR_PO_HEAD.PO_HEADER_ID,
                        P_SHIP_HEADER_ID => L_SHIP_HEADER_ID, --out
                        P_GROUP_ID       => L_GROUP_ID, --out
                        P_STATUS         => L_STATUS --out
												,P_RECEIPT_NUM   => V_RECEIPT_NUM--返回 V_RECEIPT_NUM
                        );
												
      if L_STATUS not in ('S', 'W')
      then
        MSG_OUTPUT('PO_HEADER_ID' || ':' ||
                             CR_PO_HEAD.PO_HEADER_ID || ',' ||
                             '创建采购入库头表出错.');
				V_ERROR_MSG:='CREATE_RCV_HEADER 异常；';
        raise ERR_OTHERS;
			ELSE
				MSG_OUTPUT('PO_HEADER_ID' || ':' ||
                             CR_PO_HEAD.PO_HEADER_ID || ',' ||
														 'V_RECEIPT_NUM: '||V_RECEIPT_NUM||
                             ',创建采购入库头表 完成.');
      end if;

      for CR_PO_LINE in PO_LINE(CR_PO_HEAD.PO_HEADER_ID,CR_PO_HEAD.SHIP_TO_ORGANIZATION_ID,P_PO_LINE_ID)
      loop
        BEGIN 
				L_TRANS:='OA_ITEM_ID: '||CR_PO_LINE.ITEM_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_LINE.SHIP_TO_ORGANIZATION_ID||';ITEM 控制信息获取; ';
        select B.ITEM_ID,
               B.LOT_CTL,
               B.SUBLOT_CTL
          into L_OPM_ITEM_ID,
               L_LOT_CTR,
               L_SUB_CTR
          from IC_ITEM_MST_B B
         where B.ITEM_NO =
               (select M.SEGMENT1
                  from MTL_SYSTEM_ITEMS_B M
                 where M.INVENTORY_ITEM_ID = CR_PO_LINE.ITEM_ID
                   and M.ORGANIZATION_ID =
                       CR_PO_LINE.SHIP_TO_ORGANIZATION_ID);
			  
				exception
          when others THEN
          V_ERROR_MSG := 'ITEM 控制信息获取  异常';
          RAISE ERR_OTHERS;
        END;

        L_CUR_MFG_ORG_ID := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;

        L_IFACE_RCV_REC.TRANSACTION_DATE := P_TRANS_DATE;--P_RCV_TRANS_DATE;

        select RCV_TRANSACTIONS_INTERFACE_S.nextval
          into L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID
          from DUAL;

        L_IFACE_RCV_REC.GROUP_ID := L_GROUP_ID;

        L_IFACE_RCV_REC.INTERFACE_SOURCE_CODE   :=P_REMARK;-- 'NS TO GF CPRK';--'RCV';
				L_IFACE_RCV_REC.Vendor_Lot_Num   :=p_vendor_lot_num;--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
				L_IFACE_RCV_REC.Comments   :=P_COMMENT;--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
				
        L_IFACE_RCV_REC.SOURCE_DOCUMENT_CODE    := 'PO';
        L_IFACE_RCV_REC.PROCESSING_STATUS_CODE  := 'PENDING';
        L_IFACE_RCV_REC.TRANSACTION_STATUS_CODE := 'PENDING';
        L_IFACE_RCV_REC.INSPECTION_STATUS_CODE  := 'NOT INSPECTED';
        L_IFACE_RCV_REC.DESTINATION_CONTEXT     := 'INVENTORY';
        L_IFACE_RCV_REC.DESTINATION_TYPE_CODE   := 'INVENTORY';
        L_IFACE_RCV_REC.AUTO_TRANSACT_CODE      := 'DELIVER';
        L_IFACE_RCV_REC.PROCESSING_MODE_CODE    := 'BATCH';--'ONLINE';--'IMMEDIATE';--其他两个类型没测试通，提交请求没反应
        L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE     := 'VENDOR';
        L_IFACE_RCV_REC.TRANSACTION_TYPE        := 'RECEIVE';

        L_IFACE_RCV_REC.CURRENCY_CODE := 'RMB';

        L_IFACE_RCV_REC.SHIP_TO_LOCATION_ID := CR_PO_LINE.SHIP_TO_LOCATION_ID;

        BEGIN
					L_TRANS:='SHIP_TO_ORGANIZATION_ID: '||CR_PO_LINE.SHIP_TO_ORGANIZATION_ID||';获取oa子库存; ';
          select V.SECONDARY_INVENTORY_NAME
            into L_IFACE_RCV_REC.SUBINVENTORY
            from MTL_SECONDARY_INVENTORIES_FK_V V
           where V.ORGANIZATION_ID = CR_PO_LINE.SHIP_TO_ORGANIZATION_ID
             and ROWNUM = 1;
        exception
          when others then
            MSG_OUTPUT(CR_PO_LINE.SHIP_TO_ORGANIZATION_ID || ',' ||
                                 '找不到子库存.');
						V_ERROR_MSG:='获取oa子库存 异常；';
            raise ERR_OTHERS;
        end;
        BEGIN
					L_TRANS:='SHIP_TO_ORGANIZATION_ID: '||CR_PO_LINE.SHIP_TO_ORGANIZATION_ID||';获取oa货位id; ';
          select S.INVENTORY_LOCATION_ID
            into L_IFACE_RCV_REC.LOCATOR_ID
            from MTL_ITEM_LOCATIONS S
           where S.ORGANIZATION_ID = CR_PO_LINE.SHIP_TO_ORGANIZATION_ID
             and S.SEGMENT1 =P_LOCATION--'02-01-01'-- 'C1-03-01'--P_RCV_LOCATION
             ;
        exception
          when others then
            MSG_OUTPUT(L_IFACE_RCV_REC.SUBINVENTORY || ',' ||
                                 '找不到货位 .');
						V_ERROR_MSG:='获取oa货位id 异常；';
            raise ERR_OTHERS;
        end;

        L_IFACE_RCV_REC.TO_ORGANIZATION_ID         := CR_PO_LINE.SHIP_TO_ORGANIZATION_ID;
        L_IFACE_RCV_REC.VENDOR_ID                  := CR_PO_LINE.VENDOR_ID;
        L_IFACE_RCV_REC.VENDOR_SITE_ID             := CR_PO_LINE.VENDOR_SITE_ID;
        L_IFACE_RCV_REC.ITEM_ID                    := CR_PO_LINE.ITEM_ID;
        L_IFACE_RCV_REC.ITEM_DESCRIPTION           := CR_PO_LINE.ITEM_DESCRIPTION;
        L_IFACE_RCV_REC.CATEGORY_ID                := CR_PO_LINE.CATEGORY_ID;
        L_IFACE_RCV_REC.SOURCE_DOC_UNIT_OF_MEASURE := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.UNIT_OF_MEASURE            := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
        L_IFACE_RCV_REC.UOM_CODE                   := CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE;
				
        L_IFACE_RCV_REC.QUANTITY                   := GMICUOM.UOM_CONVERSION(CR_PO_LINE.ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             P_UM,--CR_PO_LINE.Trans_Um,
                                                                             CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                             0);--CR_PO_LINE.QUANTITY;
        L_IFACE_RCV_REC.PO_UNIT_PRICE              := CR_PO_LINE.UNIT_PRICE;
        L_IFACE_RCV_REC.SECONDARY_QUANTITY         := GMICUOM.UOM_CONVERSION(CR_PO_LINE.ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             P_UM,--CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                             CR_PO_LINE.SECONDARY_UOM_CODE,
                                                                             0);

        L_IFACE_RCV_REC.SECONDARY_UNIT_OF_MEASURE := CR_PO_LINE.SECONDARY_UOM_CODE;
        L_IFACE_RCV_REC.SECONDARY_UOM_CODE        := CR_PO_LINE.SECONDARY_UOM_CODE;
        L_IFACE_RCV_REC.PRIMARY_UNIT_OF_MEASURE   := CR_PO_LINE.PRIMARY_UNIT_OF_MEASURE;
        L_IFACE_RCV_REC.PRIMARY_QUANTITY          := GMICUOM.UOM_CONVERSION(CR_PO_LINE.ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             P_UM,--CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                            CR_PO_LINE.PRIMARY_UNIT_OF_MEASURE,
                                                                            0);

        L_IFACE_RCV_REC.SOURCE_DOC_QUANTITY := GMICUOM.UOM_CONVERSION(CR_PO_LINE.ITEM_ID,
                                                                             0,
                                                                             P_QTY,
                                                                             P_UM,--CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                            CR_PO_LINE.UNIT_MEAS_LOOKUP_CODE,
                                                                            0);
        L_IFACE_RCV_REC.PO_HEADER_ID        := CR_PO_LINE.PO_HEADER_ID;
        L_IFACE_RCV_REC.ROUTING_HEADER_ID   := 3;
        L_IFACE_RCV_REC.PO_LINE_ID          := CR_PO_LINE.PO_LINE_ID;
        L_IFACE_RCV_REC.SHIPMENT_HEADER_ID  := L_SHIP_HEADER_ID; -----------
        L_IFACE_RCV_REC.PO_DISTRIBUTION_ID  := CR_PO_LINE.PO_DISTRIBUTION_ID;
        L_IFACE_RCV_REC.PO_LINE_LOCATION_ID := CR_PO_LINE.LINE_LOCATION_ID;

        L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE := CR_PO_LINE.NEED_BY_DATE;

        L_IFACE_RCV_REC.USE_MTL_LOT := 2;--2：启用批次控制；1：不启用批次控制
        L_IFACE_RCV_REC.EMPLOYEE_ID := CR_PO_LINE.AGENT_ID;

        L_IFACE_RCV_REC.USE_MTL_SERIAL := 1;--2：启用序列；1：不启用序列；

        L_IFACE_RCV_REC.ROUTING_STEP_ID := 1;

        L_IFACE_RCV_REC.LAST_UPDATE_LOGIN := P_USER_ID;
        L_IFACE_RCV_REC.LAST_UPDATED_BY   := P_USER_ID;
        L_IFACE_RCV_REC.CREATED_BY        := P_USER_ID;
        L_IFACE_RCV_REC.CREATION_DATE     := sysdate;
        L_IFACE_RCV_REC.LAST_UPDATE_DATE  := sysdate;
				
				BEGIN
					L_TRANS:='INSERT PO.RCV_TRANSACTIONS_INTERFACE; ';
        insert into PO.RCV_TRANSACTIONS_INTERFACE
          (INTERFACE_TRANSACTION_ID,
           ITEM_DESCRIPTION,
           RECEIPT_SOURCE_CODE,
           SOURCE_DOC_UNIT_OF_MEASURE,
           UNIT_OF_MEASURE,
           PRIMARY_UNIT_OF_MEASURE,
           UOM_CODE,
           CURRENCY_CODE,
           TRANSACTION_TYPE,
           INTERFACE_SOURCE_CODE,
           SOURCE_DOCUMENT_CODE,
           PROCESSING_STATUS_CODE,
           TRANSACTION_STATUS_CODE,
           INSPECTION_STATUS_CODE,
           DESTINATION_CONTEXT,
           DESTINATION_TYPE_CODE,
           AUTO_TRANSACT_CODE,
           SUBINVENTORY,
           PROCESSING_MODE_CODE,
           TO_ORGANIZATION_ID,
           PO_HEADER_ID,
           GROUP_ID,
           VENDOR_ID,
           VENDOR_SITE_ID,
           ITEM_ID,
           ROUTING_HEADER_ID,
           SHIPMENT_HEADER_ID,
           LAST_UPDATE_LOGIN,
           LAST_UPDATED_BY,
           CREATED_BY,
           PO_LINE_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           EXPECTED_RECEIPT_DATE,
           TRANSACTION_DATE,
           USE_MTL_LOT,
           EMPLOYEE_ID,
           PO_DISTRIBUTION_ID,
           PO_LINE_LOCATION_ID,
           SHIP_TO_LOCATION_ID,
           CATEGORY_ID,
           LOCATOR_ID,
           USE_MTL_SERIAL,
           SOURCE_DOC_QUANTITY,
           PO_UNIT_PRICE,
           ROUTING_STEP_ID,
           PRIMARY_QUANTITY,
           QUANTITY,
           SECONDARY_QUANTITY,
           SECONDARY_UNIT_OF_MEASURE
					 ,vendor_lot_num --add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
					 ,comments --add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
					 )
        values
          (L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID,
           L_IFACE_RCV_REC.ITEM_DESCRIPTION,
           L_IFACE_RCV_REC.RECEIPT_SOURCE_CODE,
           L_IFACE_RCV_REC.SOURCE_DOC_UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.PRIMARY_UNIT_OF_MEASURE,
           L_IFACE_RCV_REC.UOM_CODE,
           L_IFACE_RCV_REC.CURRENCY_CODE,
           L_IFACE_RCV_REC.TRANSACTION_TYPE,
           L_IFACE_RCV_REC.INTERFACE_SOURCE_CODE,
           L_IFACE_RCV_REC.SOURCE_DOCUMENT_CODE,
           L_IFACE_RCV_REC.PROCESSING_STATUS_CODE,
           L_IFACE_RCV_REC.TRANSACTION_STATUS_CODE,
           L_IFACE_RCV_REC.INSPECTION_STATUS_CODE,
           L_IFACE_RCV_REC.DESTINATION_CONTEXT,
           L_IFACE_RCV_REC.DESTINATION_TYPE_CODE,
           L_IFACE_RCV_REC.AUTO_TRANSACT_CODE,
           L_IFACE_RCV_REC.SUBINVENTORY,
           L_IFACE_RCV_REC.PROCESSING_MODE_CODE,
           L_IFACE_RCV_REC.TO_ORGANIZATION_ID,
           L_IFACE_RCV_REC.PO_HEADER_ID,
           L_IFACE_RCV_REC.GROUP_ID,
           L_IFACE_RCV_REC.VENDOR_ID,
           L_IFACE_RCV_REC.VENDOR_SITE_ID,
           L_IFACE_RCV_REC.ITEM_ID,
           L_IFACE_RCV_REC.ROUTING_HEADER_ID,
           L_IFACE_RCV_REC.SHIPMENT_HEADER_ID,
           L_IFACE_RCV_REC.LAST_UPDATE_LOGIN,
           L_IFACE_RCV_REC.LAST_UPDATED_BY,
           L_IFACE_RCV_REC.CREATED_BY,
           L_IFACE_RCV_REC.PO_LINE_ID,
           L_IFACE_RCV_REC.CREATION_DATE,
           L_IFACE_RCV_REC.LAST_UPDATE_DATE,
           L_IFACE_RCV_REC.EXPECTED_RECEIPT_DATE,
           L_IFACE_RCV_REC.TRANSACTION_DATE,
           L_IFACE_RCV_REC.USE_MTL_LOT,
           L_IFACE_RCV_REC.EMPLOYEE_ID,
           L_IFACE_RCV_REC.PO_DISTRIBUTION_ID,
           L_IFACE_RCV_REC.PO_LINE_LOCATION_ID,
           L_IFACE_RCV_REC.SHIP_TO_LOCATION_ID,
           L_IFACE_RCV_REC.CATEGORY_ID,
           L_IFACE_RCV_REC.LOCATOR_ID,
           L_IFACE_RCV_REC.USE_MTL_SERIAL,
           L_IFACE_RCV_REC.SOURCE_DOC_QUANTITY,
           L_IFACE_RCV_REC.PO_UNIT_PRICE,
           L_IFACE_RCV_REC.ROUTING_STEP_ID,
           L_IFACE_RCV_REC.PRIMARY_QUANTITY,
           L_IFACE_RCV_REC.QUANTITY,
           L_IFACE_RCV_REC.SECONDARY_QUANTITY,
           L_IFACE_RCV_REC.SECONDARY_UNIT_OF_MEASURE
					 ,L_IFACE_RCV_REC.Vendor_Lot_Num  --add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
           ,L_IFACE_RCV_REC.Comments--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
					 );
				exception
          when others THEN
          V_ERROR_MSG := 'INSERT PO.RCV_TRANSACTIONS_INTERFACE 异常';
          RAISE ERR_OTHERS;
        END;
				
        if L_LOT_CTR + L_SUB_CTR = 0
        then
          null;
        else
          L_IFACE_LOT.LAST_UPDATE_DATE  := sysdate;
          L_IFACE_LOT.LAST_UPDATED_BY   := P_USER_ID;
          L_IFACE_LOT.CREATION_DATE     := sysdate;
          L_IFACE_LOT.CREATED_BY        := P_USER_ID;
          L_IFACE_LOT.LAST_UPDATE_LOGIN := -1;

          L_IFACE_LOT.INTERFACE_TRANSACTION_ID := L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID;
          L_IFACE_LOT.QUANTITY                 := L_IFACE_RCV_REC.QUANTITY;
          L_IFACE_LOT.PRIMARY_QUANTITY         := L_IFACE_RCV_REC.PRIMARY_QUANTITY;
          L_IFACE_LOT.ITEM_ID                  := L_IFACE_RCV_REC.ITEM_ID;
          L_IFACE_LOT.TRANSACTION_DATE         := L_IFACE_RCV_REC.TRANSACTION_DATE;
          L_IFACE_LOT.EXPIRATION_DATE          := L_IFACE_RCV_REC.TRANSACTION_DATE + 365;
          L_IFACE_LOT.SECONDARY_QUANTITY       := L_IFACE_RCV_REC.SECONDARY_QUANTITY;
          L_IFACE_LOT.LOT_NUM                  := P_LOT_NO;--P_RCV_LOT_NUM;
          if L_SUB_CTR = 1
          then
            L_IFACE_LOT.SUBLOT_NUM := P_SUBLOT_NO;--P_RCV_SUBLOT_NUM;
          else
            L_IFACE_LOT.SUBLOT_NUM := null;
          end if;

          select count(*)
            into V_COUNT
            from IC_LOTS_MST T
           where T.LOT_NO = L_IFACE_LOT.LOT_NUM
             and T.ITEM_ID = L_OPM_ITEM_ID
             and NVL(T.SUBLOT_NO,
                     1) = NVL(L_IFACE_LOT.SUBLOT_NUM,
                              1);
          if V_COUNT = 0
          THEN
						BEGIN
						L_TRANS:='LOT_NO: '||L_IFACE_LOT.LOT_NUM||'；SUBLOT_NO: '||L_IFACE_LOT.SUBLOT_NUM||';批次创建; ';
            L_LOT_ID := CUX_DEVELOP_LCJ_PKG.IC_LOT_CREATE(V_ITEM_ID          => L_OPM_ITEM_ID,
                                                          V_LOT_NO           => L_IFACE_LOT.LOT_NUM,
                                                          V_SUBLOT_NO        => L_IFACE_LOT.SUBLOT_NUM,
                                                          V_ORIGINATION_TYPE => 2,
                                                          V_SHIPVEND_ID      => L_SHIPVEND_ID,
                                                          V_VENDOR_LOT_NO    => L_IFACE_RCV_REC.Vendor_Lot_Num,--CHANGE by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息--null,
                                                          V_RECV_DATE        => L_DOC_DATE,
                                                          V_QC_GRADE         => L_QC_GRADE,
                                                          V_LOT_DESC         => L_LOT_DESC,
                                                          V_COMMIT           => 'F'--'T'
																													);
						exception
							when others THEN
							V_ERROR_MSG := '批次创建  异常';
							RAISE ERR_OTHERS;
						END;
						
          end if;
          
					BEGIN
					L_TRANS:='INSERT RCV_LOTS_INTERFACE; ';	
          insert into RCV_LOTS_INTERFACE
            (LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             CREATION_DATE,
             CREATED_BY,
             LAST_UPDATE_LOGIN,
             INTERFACE_TRANSACTION_ID,
             QUANTITY,
             PRIMARY_QUANTITY,
             ITEM_ID,
             TRANSACTION_DATE,
             LOT_NUM,
             SUBLOT_NUM,
             EXPIRATION_DATE,
             SECONDARY_QUANTITY)
          values
            (L_IFACE_LOT.LAST_UPDATE_DATE,
             L_IFACE_LOT.LAST_UPDATED_BY,
             L_IFACE_LOT.CREATION_DATE,
             L_IFACE_LOT.CREATED_BY,
             L_IFACE_LOT.LAST_UPDATE_LOGIN,
             L_IFACE_LOT.INTERFACE_TRANSACTION_ID,
             L_IFACE_LOT.QUANTITY,
             L_IFACE_LOT.PRIMARY_QUANTITY,
             L_IFACE_LOT.ITEM_ID,
             L_IFACE_LOT.TRANSACTION_DATE,
             L_IFACE_LOT.LOT_NUM,
             L_IFACE_LOT.SUBLOT_NUM,
             L_IFACE_LOT.EXPIRATION_DATE,
             L_IFACE_LOT.SECONDARY_QUANTITY);
					EXCEPTION
              when others THEN
              V_ERROR_MSG := 'RCV_LOTS_INTERFACE INSERT  异常';
              RAISE ERR_OTHERS;
            END;
                    
          mtl_transaction_lots_interfac.last_update_date       := SYSDATE;  
          mtl_transaction_lots_interfac.last_updated_by        := P_USER_ID;--fnd_global.user_id;  
          mtl_transaction_lots_interfac.creation_date          := SYSDATE;  
          mtl_transaction_lots_interfac.created_by             := P_USER_ID;--fnd_global.user_id;  
          mtl_transaction_lots_interfac.last_update_login      := -1;  
          mtl_transaction_lots_interfac.product_code           := 'RCV';  
          mtl_transaction_lots_interfac.product_transaction_id :=  L_IFACE_RCV_REC.INTERFACE_TRANSACTION_ID;--rcv_transactions_interface.interface_transaction_id;  
          mtl_transaction_lots_interfac.lot_number             :=P_LOT_NO;-- P_RCV_LOT_NUM;--rec_line.lot_number;  
          
          mtl_transaction_lots_interfac.sublot_num             :=  L_IFACE_LOT.SUBLOT_NUM;
          mtl_transaction_lots_interfac.transaction_quantity   := L_IFACE_RCV_REC.QUANTITY;--l_iface_rcv_rec.quantity;  
          mtl_transaction_lots_interfac.primary_quantity       := L_IFACE_RCV_REC.PRIMARY_QUANTITY;--l_primary_qty;  
          
          SELECT mtl_material_transactions_s.NEXTVAL  
          INTO   mtl_transaction_lots_interfac.transaction_interface_id  
          FROM   dual;  
          
         -- l_primary_qty :=1;  
          BEGIN
						L_TRANS:='INSERT mtl_transaction_lots_interfac; ';	
          INSERT INTO mtl_transaction_lots_interface VALUES mtl_transaction_lots_interfac;  
          EXCEPTION
              when others THEN
              V_ERROR_MSG := 'mtl_transaction_lots_interfac INSERT  异常';
              RAISE ERR_OTHERS;
          END;
					
        end if;
      end loop;
    end loop;
    commit;

  
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      /*L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出,主体传入参数：P_FROM_CO_CODE: '||P_FROM_CO_CODE||',P_TO_CO_CODE: '||P_TO_CO_CODE||',P_TYPE: '||P_TYPE||',P_PX_ID: '||P_PX_ID||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
      */  
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
    when others THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
  END;

  
  /*###############################################################
  # NAME
  #  WMS_PO_RCV_INF
  # SYNOPSIS
  #  proc WMS_PO_RCV_INF
  # DESCRIPTION
  #  1、WMS 采购接收，采购退货，调用接口主程序
	#  2、首先进行相关参数验证，再调用采购接收 或 采购退货 程序
  ###############################################################*/       
  procedure WMS_PO_RCV_INF(
                  P_TYPE       IN VARCHAR2--类型：D:采购接收；R：采购退货；
                  ,P_PO_HEADER_ID  IN NUMBER
                  ,P_PO_LINE_ID    IN NUMBER
                  ,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,P_LOT_NO     IN VARCHAR2
                  ,P_SUBLOT_NO     IN VARCHAR2
                  ,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  ,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                  ,p_um         IN VARCHAR2--接收数量对应的单位
                  ,P_REMARK     IN VARCHAR2--备注
                  ,P_USER_NAME  IN VARCHAR2--用户名，可为空，空的时候默认：CY_ZCM
                  ,p_vendor_lot_num IN VARCHAR2--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT IN VARCHAR2--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG OUT varchar2--错误信息返回
                  ,V_RECEIPT_NUM IN OUT varchar2--D:采购接收事，返回接收号；R：采购退货，要求传入接收号；
    ) is
    cursor C is
      select distinct H.PO_HEADER_ID,
                      H.SEGMENT1
        from PO_HEADERS_ALL H
       where H.TYPE_LOOKUP_CODE = 'STANDARD'
         and H.AUTHORIZATION_STATUS = 'APPROVED'
         --and H.INTERFACE_SOURCE_CODE like P_PO_REMARK
         --AND H.CREATION_DATE LIKE SYSDATE--限制当天创建的猫单的采购订单才接受
         --AND H.SEGMENT1 =/*38655--*/38645--38642--38641--38647--38638--IN ('28682','28683')--JUST FOR TEST
         AND H.PO_HEADER_ID=P_PO_HEADER_ID
				 ;
    CR            C%rowtype;
    V_PHASE       varchar2(100);
    V_STATUS      varchar2(100);
    V_DEV_PHASE   varchar2(100);
    V_DEV_STATUS  varchar2(100);
    V_MESSAGE     varchar2(400);
    L_REQUEST_ID  number;
    V_STATUS_CODE varchar2(1);
    V_PHASE_CODE  varchar2(1);
    L_RESP_ID   NUMBER;
    
    L_TRANS                    VARCHAR2(1000);
    L_MSG                      VARCHAR2(4000);
    L_COUNT                    NUMBER:=0;
    L_ITEM_NO                  VARCHAR2(240);
		l_item_desc                VARCHAR2(240);
		
		L_LOT_ID                   NUMBER;
		--L_CO_CODE                  VARCHAR2(10):='NS';
		l_whse_code                VARCHAR2(100);
		L_WHSE_CODE_RCV            VARCHAR2(100);
		L_LOCATION_RCV            VARCHAR2(100);
		L_QTY_RCV                 NUMBER;
		
		L_DOC_ID         NUMBER;--返回的是 CMP or PND 表的 DOC_ID
    L_JOURNAL_NO     VARCHAR2(100);
  BEGIN
		
	
    
     IF l_CO_CODE LIKE 'GF'
      THEN
        L_RESP_ID:=50311;--GF.采购接收--20707;--采购超级用户
    ELSE
      SELECT DISTINCT
       Z.RESPONSIBILITY_ID
       INTO L_RESP_ID
        FROM FND_RESPONSIBILITY_VL Z
       WHERE Z.APPLICATION_ID = 201 --222--401
       AND Z.RESPONSIBILITY_NAME LIKE l_CO_CODE||'%Purchasing Super User%'

      ;
    END IF;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201)
                               ;
                               
															 
    --L_TRANS:='参数有效性校验';
    --------------------------------传入参数校验 start-------------------------------------- 
    BEGIN
    L_TRANS:='类型检查';
    IF NVL(P_TYPE,-1) NOT IN ('D','R')
      THEN
        L_MSG:=L_MSG||' 参数错误：类型检查';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：类型检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='P_ITEM_ID检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=P_ITEM_ID
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：不存在P_ITEM_ID：'||P_ITEM_ID||' 的item； ';
        RAISE err_others;
    END IF;
    
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=P_ITEM_ID
    AND (B.DELETE_MARK=1
    OR B.INACTIVE_IND=1)
    ;
    IF l_count >0
      THEN
        L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||' 已经被标记为删除或无效； ';
        RAISE err_others;
    END IF;
    
    L_COUNT:=0;
    SELECT B.ITEM_NO,b.item_desc1
    INTO L_ITEM_NO,l_item_desc
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=P_ITEM_ID
    AND (B.DELETE_MARK=0
    OR B.INACTIVE_IND=0)
    --AND b.item_desc1 NOT LIKE '%原浆%'
    ;
		/*
		 IF L_ITEM_NO LIKE '05%' -- WMS 采购接受和采购退货 都不处理 成品 2015-7-16
      THEN
     
        L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||' 传入的是成品!目前wms自动采购入库和采购退货暂不处理成品，要处理成品要修正程序； ';
        RAISE err_others;
     
    END IF;*/
		
    IF L_ITEM_NO LIKE '05-1-1%' AND l_item_desc NOT LIKE '%原浆%'
      THEN
      IF SUBSTR(L_ITEM_NO,INSTR(L_ITEM_NO,'-',-1,2)+1,INSTR(L_ITEM_NO,'-',-1,1)-INSTR(L_ITEM_NO,'-',-1,2)-1)<>'6'--非净水库存
        THEN
        L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||' 传入的不是净水成品就的item_id； ';
        RAISE err_others;
      END IF;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_ITEM_ID检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='P_TRANS_DATE 检查';
    --验证 P_TRANS_DATE 采购期间有没有打开，总账期间有没有打开，库存期间有没有打开
    L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM GL_PERIOD_STATUSES P,
       fnd_user           f,
       FND_APPLICATION_VL A,
       GL_SETS_OF_BOOKS_V S
       ,GL_PLCY_MST G
 WHERE p.last_updated_by = f.user_id
   and p.application_id = a.application_id
   and p.set_of_books_id = s.set_of_books_id
   AND G.SOB_ID=S.SET_OF_BOOKS_ID
   
   AND TRUNC(P_TRANS_DATE,'DD') >=P.START_DATE
   AND TRUNC(P_TRANS_DATE,'DD') <=P.END_DATE
   AND G.CO_CODE=L_CO_CODE
   AND A.APPLICATION_SHORT_NAME ='PO'--SQLGL 
   AND p.closing_status='O'
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||' ,采购期间没打开； ';
        RAISE err_others;
    END IF;
    
    L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM GL_PERIOD_STATUSES P,
       fnd_user           f,
       FND_APPLICATION_VL A,
       GL_SETS_OF_BOOKS_V S
       ,GL_PLCY_MST G
 WHERE p.last_updated_by = f.user_id
   and p.application_id = a.application_id
   and p.set_of_books_id = s.set_of_books_id
   AND G.SOB_ID=S.SET_OF_BOOKS_ID
   
   AND TRUNC(add_months(P_TRANS_DATE,-1),'DD') >=P.START_DATE
   AND TRUNC(add_months(P_TRANS_DATE,-1),'DD') <=P.END_DATE
   AND G.CO_CODE=L_CO_CODE
   AND A.APPLICATION_SHORT_NAME =/*'PO'--*/'SQLGL'
   AND p.closing_status='O'
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||' ,集成总账期间没打开； ';
        RAISE err_others;
    END IF;
       
    L_COUNT:=0;
    SELECT  COUNT(*)--p.closing_status --'O'是打开,
    INTO l_count
  FROM ORG_ACCT_PERIODS_V B, IC_WHSE_MST W,ORG_ORGANIZATION_DEFINITIONS A
 WHERE B.ORGANIZATION_ID = W.MTL_ORGANIZATION_ID
   AND A.ORGANIZATION_ID=B.organization_id
   
   AND W.WHSE_CODE =P_WHSE_CODE
   AND TRUNC(P_TRANS_DATE,'DD') >=B.start_date
   AND TRUNC(P_TRANS_DATE,'DD') <=B.end_date
   ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||',P_WHSE_CODE:'||P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
       
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE 检查';
      RAISE err_others;
    END;
    
  BEGIN
    L_TRANS:='P_WHSE_CODE 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
     FROM SY_ORGN_MST_VL A, IC_WHSE_MST W,GL_PLCY_MST G
 WHERE A.ORGN_CODE = W.ORGN_CODE
 AND A.CO_CODE=G.CO_CODE
   AND W.DELETE_MARK = 0
   AND A.DELETE_MARK = 0
   AND A.ORGN_CODE <> A.PARENT_ORGN_CODE
   AND A.PARENT_ORGN_CODE NOT LIKE '%LAB%'
   AND A.PARENT_ORGN_CODE NOT LIKE 'JT'
   AND W.WHSE_CODE = P_WHSE_CODE/*
   AND A.PARENT_ORGN_CODE LIKE &PARENT_ORGN_CODE --'GF'
   AND A.CO_CODE LIKE &CO_CODE*/
  ;
    IF L_COUNT<1
      THEN
         L_MSG:=L_MSG||' 参数错误：P_WHSE_CODE：'||P_WHSE_CODE||' ,接收仓库无效或不存在； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 P_WHSE_CODE 检查';
      RAISE err_others;
    END;    
    
  BEGIN
    L_TRANS:='P_LOCATION 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
     from ic_loct_mst l, ic_whse_mst w
 where l.whse_code = w.whse_code
 AND W.WHSE_CODE =P_WHSE_CODE
 AND L.LOCATION =P_LOCATION
 AND w.delete_mark=0
 AND l.delete_mark=0
  ;
    IF L_COUNT<1
      THEN
         L_MSG:=L_MSG||' 参数错误：P_LOCATION：'||P_LOCATION||',P_WHSE_CODE:'||P_WHSE_CODE||' ,接收货位无效或不存在； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 P_LOCATION 检查';
      RAISE err_others;
    END;  
    
  BEGIN
    L_TRANS:='P_QTY 检查';
    IF P_QTY<=0
      THEN
         L_MSG:=L_MSG||' 参数错误：P_QTY：'||P_QTY||' ,数量请填正数； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误 P_QTY 检查';
      RAISE err_others;
    END;
    
    BEGIN
    L_TRANS:='p_um 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO l_count
    FROM IC_ITEM_MST_B B
    WHERE B.ITEM_ID=P_ITEM_ID
    AND B.ITEM_UM=p_um
    AND (B.DELETE_MARK=0
    OR B.INACTIVE_IND=0)
    ;
    IF l_count <1
      THEN
        L_MSG:=L_MSG||' 参数错误：此P_ITEM_ID：'||P_ITEM_ID||',p_um:'||p_um||' 不是第一单位，请传入第一单位数量和第一单位； ';
        RAISE err_others;
    END IF;
   
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：p_um 检查';
      RAISE err_others;
    END;
                  
    --P_USER_NAME 不为空的时候，要获取 user_ID 到 P_USER_ID 做初始化
    --空的时候，默认用户 CY_ZCM
    --要验证接受用户，订单的接收仓库，的用户组织，仓管员权限，是否已经有，没的话报错
    --订单的接收组织和传入参数的接收仓库组织是否 一致 不一致报错
    BEGIN
    L_TRANS:='P_USER_NAME 检查';
    IF P_USER_NAME IS NOT NULL
      THEN
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM FND_USER F
WHERE F.USER_NAME = P_USER_NAME
--AND F.USER_ID LIKE &USER_ID
AND NVL(F.END_DATE,SYSDATE+1)>SYSDATE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_NAME：'||P_USER_NAME||' ,用户名不存在或已经被无效； ';
        RAISE err_others;
    END IF;
    
    SELECT F.USER_ID
    INTO P_USER_ID
     FROM FND_USER F
WHERE F.USER_NAME = P_USER_NAME
--AND F.USER_ID LIKE &USER_ID
AND NVL(F.END_DATE,SYSDATE+1)>SYSDATE
    ;
    
    END IF;
    
    --用户组织检查
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM SY_ORGN_USR A,FND_USER F,IC_WHSE_MST W
WHERE A.USER_ID=F.USER_ID
AND A.ORGN_CODE=W.ORGN_CODE
AND A.USER_ID=P_USER_ID
AND W.WHSE_CODE=P_WHSE_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_ID：'||P_USER_ID||',P_WHSE_CODE:'|| P_WHSE_CODE||' ,用户没有分配接收仓库的用户组织； ';
        RAISE err_others;
    END IF;
    
    --仓管员权限检查
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM CUX_req_whse_manager_v A
WHERE A.WHSE_CODE=P_WHSE_CODE
AND A.USER_ID=P_USER_ID
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_ID：'||P_USER_ID||',P_WHSE_CODE:'|| P_WHSE_CODE||' ,用户没有分配接收仓库的仓管员权限； ';
        RAISE err_others;
    END IF;
    
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：P_USER_NAME 检查';
      RAISE err_others;
    END;
    
    /*--追加格式
    BEGIN
    L_TRANS:='XXXX 检查';
    L_COUNT:=0;
    SELECT COUNT(*)
    INTO L_COUNT
    FROM GL_PLCY_MST G
    WHERE G.CO_CODE =P_TO_CO_CODE
  ;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：P_TRANS_DATE：'||P_TRANS_DATE||',P_WHSE_CODE:'||P_WHSE_CODE||' ,库存期间没打开； ';
        RAISE err_others;
    END IF;
    
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：XXXX 检查';
      RAISE err_others;
    END;
    */
    --------------------------------传入参数校验 END--------------------------------------
    
     IF L_CO_CODE LIKE 'GF'
      THEN
        L_RESP_ID:=50311;--GF.采购接收--20707;--采购超级用户
    ELSE
      SELECT DISTINCT
       Z.RESPONSIBILITY_ID
       INTO L_RESP_ID
        FROM FND_RESPONSIBILITY_VL Z
       WHERE Z.APPLICATION_ID = 201 --222--401
       AND Z.RESPONSIBILITY_NAME LIKE L_CO_CODE||'%Purchasing Super User%'

      ;
    END IF;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201)
                         ;
    IF P_TYPE = 'D'
      THEN                                
    for CR in C
    loop
      MSG_OUTPUT('开始接收订单' || ':' || CR.SEGMENT1);
			
			WMS_CREATE_PO_RCV(L_CO_CODE--P_CO_CODE IN VARCHAR2,
                          ,CR.PO_HEADER_ID--P_PO_HEADER_ID IN number
                  ,P_PO_LINE_ID--    IN NUMBER
                  ,P_ITEM_ID --   IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,P_LOT_NO  --   IN VARCHAR2
                  ,P_SUBLOT_NO --    IN VARCHAR2
                  ,P_TRANS_DATE-- IN DATE--采购接收或退货事务时间
                  ,P_WHSE_CODE--  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_LOCATION --  IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,P_QTY  --      IN NUMBER--接收数量,退货数量，第一单位数量
                  ,p_um   --      IN VARCHAR2--接收数量对应的单位
                  ,P_REMARK --    IN VARCHAR2--备注
                  ,P_USER_ID -- IN NUMBER--
                  ,p_vendor_lot_num--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS --OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_MESSAGE--V_ERROR_MSG OUT varchar2--错误信息返回
                  ,V_RECEIPT_NUM -- IN OUT NUMBER--D:采购接收事，返回接收号；R：采购退货，要求传入接收号；
                          );
											
			IF V_RETURN_STATUS not in ('S')
      THEN
         L_MSG:=L_MSG||' ；采购接收接口报错：'||V_MESSAGE;
        raise ERR_OTHERS;
      ELSE
        L_MSG:=L_MSG||'采购接收接口写入完成；';
      end if;										
      MSG_OUTPUT('完成接收订单' || ':' || CR.SEGMENT1);
    end loop;
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RVCTP', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,
                                               'BATCH',
                                               null,
                                               CHR(0));

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购接收请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购接收请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
    
    ELSIF P_TYPE = 'R'
      THEN 
				 
		BEGIN
    L_TRANS:='获取 采购退货的 LOT_ID';
		L_COUNT:=0;
		SELECT COUNT(*)
		INTO L_COUNT
		FROM Ic_Lots_Mst l
		WHERE L.ITEM_ID=P_ITEM_ID
		AND L.LOT_NO=P_LOT_NO
		AND L.SUBLOT_NO=P_SUBLOT_NO
		;
    IF L_COUNT<1
      THEN
        L_MSG:=L_MSG||' 参数错误：获取不了该 lot_id，LOT_NO:'||P_LOT_NO||',SUBLOT_NO:'||P_SUBLOT_NO;
        RAISE err_others;
    END IF;
    
		SELECT DISTINCT L.LOT_ID
    INTO L_LOT_ID
    FROM Ic_Lots_Mst l
    WHERE L.ITEM_ID=P_ITEM_ID
    AND L.LOT_NO=P_LOT_NO
    AND L.SUBLOT_NO=P_SUBLOT_NO
    ;
    exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：获取不了该 lot_id，LOT_NO:'||P_LOT_NO||',SUBLOT_NO:'||P_SUBLOT_NO;
      RAISE err_others;
    END;
		
		--从接收号 V_RECEIPT_NUM （接收仓库-接收号 格式）拆分出 接收仓库 和 接收号
		BEGIN
		L_TRANS:='从 V_RECEIPT_NUM 提取 接收仓库';
		SELECT SUBSTR(V_RECEIPT_NUM, 1, INSTR(V_RECEIPT_NUM, '-', 1, 1) - 1)
		INTO L_WHSE_CODE
    FROM DUAL;
		 exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：获取不了该 V_RECEIPT_NUM:'||V_RECEIPT_NUM||',接收仓库信息';
      RAISE err_others;
    END;
		
		BEGIN
		L_TRANS:='从 V_RECEIPT_NUM 提取 接收号';		
		SELECT TO_NUMBER(SUBSTR(V_RECEIPT_NUM,
														INSTR(V_RECEIPT_NUM, '-', 1, 1) + 1,
														LENGTH(V_RECEIPT_NUM) -
														INSTR(V_RECEIPT_NUM, '-', 1, 1) + 1))
		INTO V_RECEIPT_NUM
			FROM DUAL;
     exception
      when others THEN
        L_MSG:=L_MSG||' 参数错误：获取不了该 V_RECEIPT_NUM:'||V_RECEIPT_NUM||',接收号信息';
      RAISE err_others;
    END;

		--这里要增加库存现有量验证，仓库货位是不是接收的仓库货位，
		--1、是接收仓库货位，验证有没有足够库存退货，没足够库存就报错跳出异常；
		--2、不是接收仓库货位的话，验证传入参数的退货仓库退货货位有没有足够库存
		--      2.1、有足够库存就库存转移到接收的仓库货位，并传入采购接收退货的仓库货位
		--      2.2、没足够库存就报错跳出异常，不继续执行
		BEGIN
    L_TRANS:='获取 接收仓库，接收货位 信息';
		SELECT  P.WHSE_CODE
 ,P.LOCATION
 ,SUM(P.TRANS_QTY) TRANS_QTY
		INTO L_WHSE_CODE_RCV,L_LOCATION_RCV  ,L_QTY_RCV  
		FROM PO_HEADERS_ALL       PHA,
       RCV_TRANSACTIONS     RT,
       PO_VENDORS           PV,
       PO_LINES_ALL         PLA,
       RCV_SHIPMENT_HEADERS RSH,
       IC_TRAN_PND          P,
       IC_LOTS_MST          L,
      -- PO_HEADERS_RFQQT_V   BJH,

             PO_LINE_LOCATIONS_ALL LL,
             PO_DISTRIBUTIONS_ALL  D,
             MTL_SYSTEM_ITEMS_B    B
          --   ,RCV_LOT_TRANSACTIONS LT
 WHERE RT.PO_LINE_ID = PLA.PO_LINE_ID
   --AND PLA.FROM_HEADER_ID = BJH.PO_HEADER_ID(+)
   AND P.ITEM_ID = L.ITEM_ID
   AND P.LOT_ID = L.LOT_ID
   AND RT.SHIPMENT_HEADER_ID = RSH.SHIPMENT_HEADER_ID
   AND PLA.PO_HEADER_ID = PHA.PO_HEADER_ID
   AND PHA.VENDOR_ID = PV.VENDOR_ID
   AND RT.TRANSACTION_TYPE-- ='DELIVER'
	 IN ('DELIVER',
                               'CORRECT', /* 'RETURN TO RECEIVING',*/
                               'RETURN TO VENDOR')
      
   --AND TO_CHAR(RT.TRANSACTION_DATE, 'YYYYMM') LIKE &YYYYMM --'%2010%' --= '05-2010' 
      /* AND PLA.ORG_ID = \*:p_org_id  --*\
      '123'*/
   AND RT.SHIPMENT_HEADER_ID = P.DOC_ID
   AND P.LINE_ID = RT.TRANSACTION_ID
   AND P.DOC_TYPE = 'PORC'
   AND P.DELETE_MARK = 0
   AND P.COMPLETED_IND = 1
   
   /*   
   AND PHA.SEGMENT1 LIKE &PO_NUMBER --'5042'
   AND RSH.RECEIPT_NUM LIKE &RCV_NUMBER
   AND (SELECT MSI.SEGMENT1
          FROM MTL_SYSTEM_ITEMS_B MSI
         WHERE MSI.INVENTORY_ITEM_ID = PLA.ITEM_ID
           AND ROWNUM = 1) LIKE &ITEM_NO
      
   AND P.CO_CODE LIKE &CO_CODE
   AND P.WHSE_CODE LIKE &WHSE_CODE
   */
   and pLa.PO_LINE_ID = LL.PO_LINE_ID
         and pLa.PO_LINE_ID = D.PO_LINE_ID
         and pLa.PO_HEADER_ID = D.PO_HEADER_ID
         and pLa.ITEM_ID = B.INVENTORY_ITEM_ID
         and LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
        
   
   --AND RT.transaction_id = LT.SOURCE_TRANSACTION_ID(+)
        --AND ll.quantity_received>0
        
        AND RSH.RECEIPT_NUM =V_RECEIPT_NUM--71567
        AND p.whse_code=L_WHSE_CODE--'PX21'
        AND P.ITEM_ID=P_ITEM_ID
        AND P.LOT_ID=L_LOT_ID
				
				GROUP BY P.WHSE_CODE
 ,P.LOCATION
    ;
     exception
      when others THEN
        L_MSG:=L_MSG||' 获取不了该 V_RECEIPT_NUM:'||V_RECEIPT_NUM||' ,L_WHSE_CODE:'||L_WHSE_CODE||',接收的仓库和接收货位信息';
      RAISE err_others;
    END;
		
		BEGIN
			L_TRANS := '采购退货数量 检查';
			IF L_QTY_RCV < 1 OR L_QTY_RCV < P_QTY THEN
				L_MSG := L_MSG || ' 采购退货数量：P_QTY：' || P_QTY ||
								 ',大于可退货数量：L_QTY_RCV:' || L_QTY_RCV || '； ';
				RAISE err_others;
			END IF;

		exception
			when others THEN
				L_MSG := L_MSG || ' 采购退货数量 检查';
				RAISE err_others;
		END;
		
		BEGIN
        L_TRANS:='要退货的 仓库 货位 验证是否有足够库存量 退货'; 
        L_QTY_RCV:=0;
         SELECT P.LOCT_ONHAND
          INTO L_QTY_RCV
          FROM IC_ITEM_MST_B I, IC_LOCT_INV P, IC_LOTS_MST L
         WHERE P.ITEM_ID = I.ITEM_ID
           AND P.ITEM_ID = L.ITEM_ID
           AND P.LOT_ID = L.LOT_ID
              --AND P.LOCT_ONHAND <>0  
           AND P.ITEM_ID = P_ITEM_ID
           and p.lot_id = L_LOT_ID
           AND P.LOCATION = P_LOCATION
           AND P.WHSE_CODE = P_WHSE_CODE;

        IF L_QTY_RCV < P_QTY THEN
          L_MSG := L_MSG || ' 要退货的仓库：P_WHSE_CODE：' || P_WHSE_CODE ||
                   ',退货货位：P_LOCATION:' || P_LOCATION || ' ,现有量不够要求退货的数量：P_QTY' ||
                   P_QTY || '； ';
          RAISE err_others;
        END IF;
         exception
          when others THEN
            L_MSG:=L_MSG||' ;'||L_TRANS||' 异常';
          RAISE err_others;
        END;
				
    BEGIN
    L_TRANS:='接收仓库和货位与传入参数要退货的仓库货位 不一致';    
    IF L_WHSE_CODE_RCV<>P_WHSE_CODE OR  L_LOCATION_RCV<>P_LOCATION--接收仓库货位不一致
			THEN	
				BEGIN
        L_TRANS:='要退货的 仓库 货位 库存量 转移 到 采购接收的仓库货位'; 
         CUX_DEVELOP_NS_OPM_PKG.CREATE_TRANS('XFER',--V_TRANS_TYPE    IN VARCHAR2,--XFER CREI ADJI TRIN
                    P_USER_NAME   ,--       IN VARCHAR2,
                    L_CO_CODE,--V_CO_CODE       IN VARCHAR2,
                    SUBSTR(P_WHSE_CODE,1,3)||'0',--V_ORGN_CODE     IN VARCHAR2,
                    --V_ITEM_ID       IN NUMBER,
                    L_ITEM_NO ,--      IN VARCHAR2,
                    P_LOT_NO  ,--      IN VARCHAR2,
                    P_SUBLOT_NO ,--    IN VARCHAR2,
                    --V_LOT_STATUS    IN VARCHAR2,
                    P_QTY,--V_TRAN_QTY      IN NUMBER,--第一单位数量
                    P_WHSE_CODE,--V_WHSE_CODE_F   IN VARCHAR2,
                    L_WHSE_CODE_RCV,--V_WHSE_CODE_T   IN VARCHAR2,
                    P_LOCATION,--V_FROM_LOCATION IN VARCHAR2,
                    L_LOCATION_RCV,--V_TO_LOCATION   IN VARCHAR2,
                    --V_DEFAULT_LOCT  IN VARCHAR2,
                   NULL,--V_REASON_CODE   IN VARCHAR2,
                    P_TRANS_DATE,--V_TRANS_DATE   IN DATE,
                    'WMS PO RETURN ONHAND XFER TO RCV WHSECODE LOCATION',--V_REMARK   IN VARCHAR2,
                    L_DOC_ID ,--       OUT NUMBER,--返回的是 CMP or PND 表的 DOC_ID
                    L_JOURNAL_NO ,--   OUT VARCHAR2,
                    V_RETURN_STATUS,-- OUT VARCHAR2,
                    V_ERROR_MSG    -- OUT VARCHAR2
										)
				 ;
				 if V_RETURN_STATUS not in ('S')
					THEN
						 L_MSG:=L_MSG||' ；WMS采购退货自动产生转移事务报错：'||V_ERROR_MSG;
						raise ERR_OTHERS;
					ELSE
						L_MSG:=L_MSG||'WMS采购退货自动产生转移事务正常完成；';
					end if;
			
         exception
          when others THEN
            L_MSG:=L_MSG||' ;'||L_TRANS||' 异常';
          RAISE err_others;
        END;
				
		END IF;
		
     exception
      when others THEN
        L_MSG:=L_MSG||' ;'||L_TRANS||' 异常';
      RAISE err_others;
    END;
		
        V_RETURN_STATUS:='S';
				V_MESSAGE:=NULL;
		
        CREATE_PO_RETURN( L_WHSE_CODE_RCV--L_WHSE_CODE  --找接收事务的 游标 用这个参数
                          ,V_RECEIPT_NUM--接收号--'71567'--P_RCV_NO  
                          ,P_ITEM_ID   
                          ,L_LOT_ID    
                          ,P_TRANS_DATE  --采购接收或退货事务时间
                          ,L_WHSE_CODE_RCV--P_WHSE_CODE   --接口表要求退货的仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,L_LOCATION_RCV--P_LOCATION    --接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                          ,P_QTY         --接收数量,退货数量，第一单位数量
                          ,p_um          --接收数量对应的单位
                          ,P_REMARK     --备注
                  ,p_vendor_lot_num--供应商批次信息--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,P_COMMENT--备注--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                          ,V_RETURN_STATUS --返回状态：S-正常完成，E-异常终止
                          ,V_MESSAGE --错误信息返回                          
                          )
                          ;
        
      if V_RETURN_STATUS not in ('S')
      THEN
         L_MSG:=L_MSG||' ；采购退货接口报错：'||V_MESSAGE;
        raise ERR_OTHERS;
      ELSE
        L_MSG:=L_MSG||'采购退货接口写入完成；';
      end if;
      
        FND_GLOBAL.APPS_INITIALIZE(USER_ID      => P_USER_ID_SYS,
                               RESP_ID      => L_RESP_ID,--20707,
                               RESP_APPL_ID => 201);
   

    L_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('PO', --APPLICATIONI SHORT NAME;
                                               'RVCTP', --PROGRAME SHORT NAME;--"接收事务处理处理器"请求
                                               null,
                                               null,
                                               false,
                                               'BATCH',
                                               null,
                                               CHR(0));

    commit;
    if FND_CONCURRENT.WAIT_FOR_REQUEST(L_REQUEST_ID,
                                       5,
                                       0,
                                       V_PHASE,
                                       V_STATUS,
                                       V_DEV_PHASE,
                                       V_DEV_STATUS,
                                       V_MESSAGE)
       and L_REQUEST_ID <> 0
    then
      begin
        select PHASE_CODE,
               STATUS_CODE
          into V_PHASE_CODE,
               V_STATUS_CODE
          from FND_CONC_REQ_SUMMARY_V T
         where T.REQUEST_ID = L_REQUEST_ID;

      end;

      if V_PHASE_CODE = 'C'
         and V_STATUS_CODE = 'C'
      then
        MSG_OUTPUT('l_request_id: ' || L_REQUEST_ID);
      elsif V_PHASE_CODE = 'C'
            and V_STATUS_CODE <> 'C'
      then
        MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
        raise ERR_OTHERS;
      end if;
    else
      MSG_OUTPUT('请求发生错误，请联系系统管理员！');
         L_MSG:=L_MSG||'采购退货请求发生错误，请联系系统管理员！';
      raise ERR_OTHERS;
    end if;
    
      
    
    END IF;
    
    V_RETURN_STATUS := 'S';
       L_MSG:=L_MSG||'采购接口事务产生完成';
      -- L_MSG:=L_MSG||'传入参数：L_CO_CODE: '||l_co_code||',l_period_code: '||l_period_code;--||',l_type: '||l_type;
    V_ERROR_MSG:=L_MSG;
      /* FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================result========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||V_ERROR_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'V_RETURN_STATUS： '||V_RETURN_STATUS);--日志输出
        */
        MSG_OUTPUT('================result========================');
        MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
				MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);/*
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,256,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,500,255));
        
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,756,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1000,255));*/
        
      exception
      WHEN err_others THEN
        V_RETURN_STATUS := 'E';
       L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出';--' 过程异常退出,主体传入参数：L_CO_CODE: '||L_CO_CODE||',P_TYPE: '||P_TYPE||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_NO: '||P_LOT_NO||',P_SUBLOT_NO: '||P_SUBLOT_NO||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
				MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);/*
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,256,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,500,255));
        
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,756,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1000,255));*/
        /*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||V_ERROR_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'V_RETURN_STATUS： '||V_RETURN_STATUS);--日志输出
        */
      when others then
       V_RETURN_STATUS := 'E';
        V_ERROR_MSG:=L_MSG||';'||L_TRANS||'  '|| SQLERRM;
        MSG_OUTPUT('================exception========================');
        MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
				MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
       /* MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,256,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,500,255));
        
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,756,255));
        MSG_OUTPUT(SUBSTR('V_ERROR_MSG: '||V_ERROR_MSG,1000,255));*/
        
        /*
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '================exception========================');
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, 'ERR_MSG： '||V_ERROR_MSG);--日志输出   
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT,  'V_RETURN_STATUS： '||V_RETURN_STATUS);--日志输出
        */
  end;
	
/*###############################################################
  # NAME
  #  WMS_PO_ORDER
  # SYNOPSIS
  #  proc WMS_PO_ORDER
  # DESCRIPTION
  #  1、采购订单信息写入WMS
  #  2、过程有 COMMIT
	#  3、抽取“LAST_UPDATE_DATE”大于nvl（L_REQ_DATE，L_INI_REQ_DATE[前一小时]）的采购订单的记录
	#  4、限制只取南沙的批准状态的采购订单信息
	#  5、编码只排除瓶，塑箱，文具，珠丰编码，荣鑫编码，09%编码，04%编码，其他编码都取
  ###############################################################*/  
procedure WMS_PO_ORDER(L_REQ_DATE IN DATE,
                    V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2)
   AS
	 
		--L_CO_CODE         VARCHAR2(10):='GF';--'NS';--启用时要更改
    --L_RESULT    BOOLEAN;
    
    /*ERR_PARAMETER EXCEPTION;
    ERR_NO_DATA EXCEPTION;
    ERR_OTHERS EXCEPTION;*/
    L_TRANS                    VARCHAR2(1000);
    L_MSG     VARCHAR2(4000) := ' ';
    
    --V_RETURN_STATUS VARCHAR2(10):='S';
    --V_ERROR_MSG     VARCHAR2(4000);
		
		L_RETURN_STATUS_U VARCHAR2(10);
		
		cursor PO_HEADRE IS
		 --HEADER
	 SELECT DISTINCT 
	 --H.CLOSED_CODE,--CLOSED，OPEN--wms 传这个状态
	 --H.authorization_status,
 --G.CO_CODE || '-' || H.SEGMENT1 PO_NUM,
 SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1)|| '-' || H.SEGMENT1 PO_NUM,
 H.VENDOR_ID,
 --H.VENDOR_SITE_ID,
 H.ORG_ID,
 --H.CURRENCY_CODE,
 H.AGENT_ID, --采购员 employee_id
 L.PO_HEADER_ID,
 /*L.PO_LINE_ID,
 LL.LINE_LOCATION_ID,*/
 --D.PO_DISTRIBUTION_ID,
 --LL.SHIP_TO_LOCATION_ID,
 LL.SHIP_TO_ORGANIZATION_ID, --接收组织
 SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1) WHSE_CODE,
 H.CREATION_DATE
 /*-- L.ITEM_ID,--OA item id
 -- L.ITEM_DESCRIPTION,--OA item
 -- L.CATEGORY_ID,
 I.ITEM_ID,
 I.ITEM_NO,
 I.ITEM_DESC1,
 --L.QUANTITY QUANTITY,
 GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                        0,
                        L.QUANTITY,
                        L.UNIT_MEAS_LOOKUP_CODE,
                        i.ITEM_UM,
                        0) QTY1,
GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                      0,
                      LL.QUANTITY -LL.QUANTITY_RECEIVED,
                       L.UNIT_MEAS_LOOKUP_CODE,
                      I.ITEM_UM,
                      0) QTY1,
/* GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                        0,
                        L.QUANTITY,
                        L.UNIT_MEAS_LOOKUP_CODE,
                        i.ITEM_UM2,
                        0) QTY2,
 L.UNIT_MEAS_LOOKUP_CODE, --订单行单位
 B.PRIMARY_UNIT_OF_MEASURE, --主单位
 B.SECONDARY_UOM_CODE, --第二单位
 I.ITEM_UM,
 --LL.QUANTITY_RECEIVED QUANTITY,
 -- LL.QUANTITY - LL.QUANTITY_RECEIVED QUANTITY,
  L.UNIT_PRICE, --单价*/
 --NVL(LL.NEED_BY_DATE, LL.PROMISED_DATE) REQ_DATE
 --,DECODE(I.STATUS_CTL,0,1,2) STATUS--STATUS_CTL=0 : 没批次状态控制；返回：1=合格，2=不合格*/
 
  FROM PO_HEADERS_ALL        H,
       PO_LINES_ALL          L,
       PO_LINE_LOCATIONS_ALL LL,
       --PO_DISTRIBUTIONS_ALL  D,
       MTL_SYSTEM_ITEMS_B B,
       GL_PLCY_MST        G,
       CUX_NS_WMS_ITEM_V  I
       ,ORG_ORGANIZATION_DEFINITIONS O
 WHERE H.PO_HEADER_ID = L.PO_HEADER_ID
   AND H.PO_HEADER_ID = LL.PO_HEADER_ID
   AND L.PO_LINE_ID = LL.PO_LINE_ID
      --AND L.PO_LINE_ID = D.PO_LINE_ID
      --AND L.PO_HEADER_ID = D.PO_HEADER_ID
   AND L.ITEM_ID = B.INVENTORY_ITEM_ID
   AND LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
   AND H.ORG_ID = G.ORG_ID
      --AND ll.quantity_received>0
      -- and H.PO_HEADER_ID = 92870--L_PO_HEADER_ID
      -- AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
   AND B.SEGMENT1 = I.ITEM_NO
   AND LL.SHIP_TO_ORGANIZATION_ID=O.ORGANIZATION_ID
      
   AND G.CO_CODE = L_CO_CODE--'GF' --'NS'
      --AND B.ORGANIZATION_ID=85
      
   AND L.CANCEL_FLAG <> 'Y'
   AND H.TYPE_LOOKUP_CODE = 'STANDARD'
   AND H.AUTHORIZATION_STATUS = 'APPROVED'
       and LL.QUANTITY > LL.QUANTITY_RECEIVED--未接收完的采购订单才抽取
      
   AND H.LAST_UPDATE_DATE > NVL(L_REQ_DATE,L_INI_REQ_DATE)

AND NVL(H.ATTRIBUTE2,'N')<>'Y'--ADD BY JSJ_HKX 2015-9-25 FOR 排除 预签订单

AND H.SEGMENT1=402--323--255 --ADD BY JSJ_HKX 2015-10-21 FOR TEST

;
		
		cursor PO_LINE(L_PO_HEADER_ID NUMBER,L_SHIP_TO_ORGANIZATION_ID NUMBER) IS
		--LINE  
		SELECT --H.authorization_status,
 --G.CO_CODE || '-' || H.SEGMENT1 PO_NUM,
-- H.VENDOR_ID,
 --H.VENDOR_SITE_ID,
 H.ORG_ID,
 --H.CURRENCY_CODE,
-- H.AGENT_ID, --采购员 employee_id
 L.PO_HEADER_ID,
 L.PO_LINE_ID,
 LL.LINE_LOCATION_ID,
 --D.PO_DISTRIBUTION_ID,
 --LL.SHIP_TO_LOCATION_ID,
 LL.SHIP_TO_ORGANIZATION_ID, --接收组织
 SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1) WHSE_CODE,
 -- L.ITEM_ID,--OA item id
 -- L.ITEM_DESCRIPTION,--OA item
 -- L.CATEGORY_ID,
 I.ITEM_ID,
 I.ITEM_NO,
 I.ITEM_DESC1,
 --L.QUANTITY QUANTITY,
/* GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                        0,
                        L.QUANTITY,
                        L.UNIT_MEAS_LOOKUP_CODE,
                        i.ITEM_UM,
                        0) QTY1,*/
GMICUOM.UOM_CONVERSION(I.ITEM_ID,
											0,
											LL.QUANTITY -LL.QUANTITY_RECEIVED,
											 L.UNIT_MEAS_LOOKUP_CODE,
											I.ITEM_UM,
											0) QTY1,
																																						
/* GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                        0,
                        L.QUANTITY,
                        L.UNIT_MEAS_LOOKUP_CODE,
                        i.ITEM_UM2,
                        0) QTY2,
 L.UNIT_MEAS_LOOKUP_CODE, --订单行单位
 B.PRIMARY_UNIT_OF_MEASURE, --主单位
 B.SECONDARY_UOM_CODE, --第二单位*/
 I.ITEM_UM--,
 --LL.QUANTITY_RECEIVED QUANTITY,
 -- LL.QUANTITY - LL.QUANTITY_RECEIVED QUANTITY,
 -- L.UNIT_PRICE, --单价
 ,NVL(LL.NEED_BY_DATE, LL.PROMISED_DATE) REQ_DATE
 ,DECODE(I.STATUS_CTL,0,1,NULL) STATUS--STATUS_CTL=0 : 没批次状态控制；返回：1=合格，2=不合格
 ,L.ATTRIBUTE5 SUBLOT_NO--采购订单行 弹性域记录的 子批次
  FROM PO_HEADERS_ALL        H,
       PO_LINES_ALL          L,
       PO_LINE_LOCATIONS_ALL LL,
       --PO_DISTRIBUTIONS_ALL  D,
       MTL_SYSTEM_ITEMS_B B,
       GL_PLCY_MST        G,
       CUX_NS_WMS_ITEM_V  I
			 ,ORG_ORGANIZATION_DEFINITIONS O
 WHERE H.PO_HEADER_ID = L.PO_HEADER_ID
   AND H.PO_HEADER_ID = LL.PO_HEADER_ID
   AND L.PO_LINE_ID = LL.PO_LINE_ID
      --AND L.PO_LINE_ID = D.PO_LINE_ID
      --AND L.PO_HEADER_ID = D.PO_HEADER_ID
   AND L.ITEM_ID = B.INVENTORY_ITEM_ID
   AND LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
   AND H.ORG_ID = G.ORG_ID
      --AND ll.quantity_received>0
      -- and H.PO_HEADER_ID = 92870--L_PO_HEADER_ID
      -- AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
   AND B.SEGMENT1 = I.ITEM_NO
	 AND LL.SHIP_TO_ORGANIZATION_ID=O.ORGANIZATION_ID
      
   AND G.CO_CODE = L_CO_CODE--'GF' --'NS'
      --AND B.ORGANIZATION_ID=85
      
   AND L.CANCEL_FLAG <> 'Y'
   AND H.TYPE_LOOKUP_CODE = 'STANDARD'
   AND H.AUTHORIZATION_STATUS = 'APPROVED'
       and LL.QUANTITY > LL.QUANTITY_RECEIVED--未接收完的采购订单才抽取
      
  -- AND H.LAST_UPDATE_DATE >NVL(L_REQ_DATE,L_INI_REQ_DATE)
	 
   AND H.PO_HEADER_ID=L_PO_HEADER_ID--92906
	 AND LL.SHIP_TO_ORGANIZATION_ID=L_SHIP_TO_ORGANIZATION_ID--116


AND NVL(H.ATTRIBUTE2,'N')<>'Y'--ADD BY JSJ_HKX 2015-9-25 FOR 排除 预签订单
;
		
		CR_PO_HEADER PO_HEADRE%ROWTYPE;
    CR_PO_LINE PO_LINE%rowtype;
		
		L_COUNT    NUMBER:=0;
		
		L_RETURN_STATUS VARCHAR2(10):='S';
    L_ERROR_MSG     VARCHAR2(4000);
		r_ERR_IN  CUX_DEVELOP_NS_OPM_PKG.R_ERR;--异常记录表
		
		r_IN_HEADER_IN  CUX_DEVELOP_NS_OPM_PKG.R_IN_HEADER;--入库中间表 头表
		L_IN_HESDER_ID  NUMBER;--入库中间表 头表 返回的 头序列
		r_IN_LINE_IN  CUX_DEVELOP_NS_OPM_PKG.R_IN_LINE;--入库中间表 行表
  BEGIN
    L_TRANS:='INSERT WMS PO ORDER';
    
		L_TRANS:='INSERT WMS PO HESDER LOOP START';
		for CR_PO_HEADER in PO_HEADRE
			LOOP
				L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSE_CODE: '||CR_PO_HEADER.WHSE_CODE||' 验证是否已经存在于WMS表';
				L_COUNT:=0;
		    SELECT COUNT(*) 
				INTO L_COUNT
				FROM CENTER_IN_NOTIFY H
				WHERE H.C_IN_ERPID=CR_PO_HEADER.PO_HEADER_ID
				AND H.C_IN_Warehouse=CR_PO_HEADER.WHSE_CODE
				;
				IF L_COUNT >0--已经存在该 采购订单 不再写入该记录到 wms 接口表
					THEN
						/*
						L_RETURN_STATUS_U := 'U';
            V_ERROR_MSG:=V_ERROR_MSG||' PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSEC_CODE: '||CR_PO_HEADER.WHSEC_CODE||'；已经存在于 WMS 接口表中 此id的记录不会写入 wms 接口表中，请检查异常记录表检查该订单为什么会更新！';
						
						BEGIN
						 r_ERR_IN.sys_code :='ERP';
						 r_ERR_IN.table_name :='CENTER_IN_NOTIFY';
						 r_ERR_IN.err_date :=SYSDATE ;
						 r_ERR_IN.erp_doc_type :='PO ORDER INSERT';
						 r_ERR_IN.wms_header_id :=NULL;
						 r_ERR_IN.wms_line_id :=NULL;
						 r_ERR_IN.erp_header_id :=CR_PO_HEADER.PO_HEADER_ID;
						 r_ERR_IN.erp_line_id :=NULL;
						 r_ERR_IN.erp_id :=NULL;
						 r_ERR_IN.co_code :=L_CO_CODE;--'NS';
						 r_ERR_IN.whse_code :=CR_PO_HEADER.WHSEC_CODE;--'TCP1';
						 r_ERR_IN.erp_no :=CR_PO_HEADER.PO_NUM;--'CP00-0001';
						 r_ERR_IN.err_msg :=V_ERROR_MSG;--'ERRXXXXXXXXX';
						 r_ERR_IN.remark :=' PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSEC_CODE: '||CR_PO_HEADER.WHSEC_CODE;--'XXXXXXXXXXX';
						 r_ERR_IN.item_no :='';
						 r_ERR_IN.lot_on  :='';
						 r_ERR_IN.sublot_no  :='';
						 r_ERR_IN.qty  :=NULL;          
					             
						 L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSEC_CODE: '||CR_PO_HEADER.WHSEC_CODE||' INSERT 异常记录表';
						 
            L_RETURN_STATUS:='S';
            L_ERROR_MSG:='';
							insert_err(r_ERR_IN,
															 L_RETURN_STATUS,
															 L_ERROR_MSG  );
					    
							IF L_RETURN_STATUS <>'S'
								THEN
									V_RETURN_STATUS:=L_RETURN_STATUS;
									V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
									RAISE ERR_OTHERS;
							END IF;
							END;
						*/--现在程序是依据 last_update_date 抽数，如果在抽数后未到抽数间隔又重新抽数，就会有 wms 接口表已经存在该记录的情况，这也是正常的啊，如果wms存在该记录就写入异常表，那么异常表就会很多不是有问题的数据；应该要验证wms接口表数据和抽数数据不一致的时候才写入异常表
					
					------------------------WMS 数据核对 line 循环 START----------------------------------	
				L_TRANS:='WMS 数据核对：PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID||', WMS PO LINE LOOP START'; 
        FOR CR_PO_LINE in PO_LINE(CR_PO_HEADER.Po_Header_Id,CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID)
          LOOP
            BEGIN
							L_COUNT:=0;
						 SELECT COUNT(*) 
						 INTO L_COUNT
						 FROM 
						 CENTER_IN_NOTIFY H,CENTER_IN_NOTIFYDETAIL L
						 WHERE H.C_IN_ID=L.C_IN_ID
						 AND L.C_IN_Flag=1--WMS 未处理
						 --AND H.C_IN_Flag=1--WMS 未处理
						 AND H.C_IN_ERPID=CR_PO_HEADER.PO_HEADER_ID
						 AND H.C_IN_Warehouse=CR_PO_HEADER.WHSE_CODE
						 AND L.C_IN_ERPOrder=CR_PO_LINE.PO_LINE_ID
						 
						 AND (
						 H.C_IN_ERPNO <>CR_PO_HEADER.PO_NUM
						 --OR C_IN_Founder <>CR_PO_HEADER.AGENT_ID
						 OR c_in_customerid <>CR_PO_HEADER.VENDOR_ID
						 OR C_IN_ProductId <>CR_PO_LINE.ITEM_ID
						 OR C_IN_Unit <>CR_PO_LINE.ITEM_UM
						 OR C_IN_State <>CR_PO_LINE.STATUS
						 OR C_IN_Num <>CR_PO_LINE.QTY1
						 OR C_IN_ZBatchno <>CR_PO_LINE.SUBLOT_NO
						 OR C_IN_ReceiveTime <>CR_PO_LINE.REQ_DATE
						 )
						 ;
						IF L_COUNT>0--写入异常表，要人工核对为什么写入 WMS 后 数据还被更新了
							THEN
								       
							BEGIN
							 r_ERR_IN.sys_code :='ERP';
							 r_ERR_IN.table_name :='CENTER_IN_NOTIFY';
							 r_ERR_IN.err_date :=SYSDATE ;
							 r_ERR_IN.erp_doc_type :='PO ORDER HEADER INSERT BUT WMS EXIST';
							 r_ERR_IN.wms_header_id :=NULL;
							 r_ERR_IN.wms_line_id :=NULL;
							 r_ERR_IN.erp_header_id :=CR_PO_HEADER.PO_HEADER_ID;
							 r_ERR_IN.erp_line_id :=CR_PO_LINE.PO_LINE_ID;
							 r_ERR_IN.erp_id :=NULL;
							 r_ERR_IN.co_code :=L_CO_CODE;--'NS';
							 r_ERR_IN.whse_code :=CR_PO_HEADER.WHSE_CODE;--'TCP1';
							 r_ERR_IN.erp_no :=CR_PO_HEADER.PO_NUM;--'CP00-0001';
							 r_ERR_IN.err_msg :='WMS已存在该po_header_id和po_line_id记录，但抽数发现数据表被更新，未写入到wms接口表，请检查为什么数据被更新';--'ERRXXXXXXXXX';
							 r_ERR_IN.remark :='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID||'；PO_LINE_ID: '||CR_PO_LINE.PO_LINE_ID;--'XXXXXXXXXXX';
							 r_ERR_IN.item_no :=CR_PO_LINE.ITEM_NO;
							 r_ERR_IN.lot_on  :='';
							 r_ERR_IN.sublot_no  :='';
							 r_ERR_IN.qty  :=CR_PO_LINE.QTY1;          
	                       
							 L_TRANS:='PO_LINE_ID: '||CR_PO_LINE.PO_LINE_ID||'；'||L_TRANS;
							L_RETURN_STATUS:='S';
							L_ERROR_MSG:='';
								CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
																 L_RETURN_STATUS,
																 L_ERROR_MSG  );
	              
							/*  IF L_RETURN_STATUS <>'S'
									THEN
										V_RETURN_STATUS:=L_RETURN_STATUS;
										V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
										RAISE ERR_OTHERS;
								END IF;*/
								END;
						END IF;
             
           
              END;
            
            end loop;--LINE LOOP END
						------------------------WMS 数据核对 line 循环 end----------------------------------
						
				ELSE--正常写入头表信息
				 BEGIN
				 r_IN_HEADER_IN.C_IN_ERPID :=CR_PO_HEADER.PO_HEADER_ID;
				 r_IN_HEADER_IN.C_IN_ERPNO :=CR_PO_HEADER.PO_NUM;
				 r_IN_HEADER_IN.C_IN_Type :=9 ;
				 r_IN_HEADER_IN.C_IN_Date :=CR_PO_HEADER.CREATION_DATE;--TO_CHAR(CR_PO_HEADER.CREATION_DATE,'YYYY-MM-DD HH24:MI:SS');
				 r_IN_HEADER_IN.C_IN_Warehouse :=CR_PO_HEADER.WHSE_CODE;
				 --r_IN_HEADER_IN.C_IN_Founder :=CR_PO_HEADER.AGENT_ID;
				 BEGIN
					SELECT DISTINCT F.USER_ID
					INTO r_IN_HEADER_IN.C_IN_Founder
					FROM FND_USER F
					WHERE F.EMPLOYEE_ID=CR_PO_HEADER.AGENT_ID
					;
				 exception
					when others THEN
					r_IN_HEADER_IN.C_IN_Founder :=-1;
				 END;
				 r_IN_HEADER_IN.c_in_customerid :=CR_PO_HEADER.VENDOR_ID;
				 r_IN_HEADER_IN.C_IN_CarrierName :='';
				 r_IN_HEADER_IN.C_IN_PutComplete :='';
				 r_IN_HEADER_IN.C_IN_Flag :=1;
				 r_IN_HEADER_IN.C_IN_Time :=SYSDATE;--TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS');
				 r_IN_HEADER_IN.c_in_traynum :='';
				 
				 L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSE_CODE: '||CR_PO_HEADER.WHSE_CODE||';INSERT WMS 入库中间表 头表';
				 
				 L_RETURN_STATUS:='S';
            L_ERROR_MSG:='';
					CUX_DEVELOP_NS_OPM_PKG.insert_IN_HEADER(r_IN_HEADER_IN,
													 L_IN_HESDER_ID,
													 L_RETURN_STATUS,
													 L_ERROR_MSG  );
			    
					IF L_RETURN_STATUS <>'S'
						THEN
              V_RETURN_STATUS:=L_RETURN_STATUS;
              V_ERROR_MSG:=L_ERROR_MSG;
						
						BEGIN
             r_ERR_IN.sys_code :='ERP';
             r_ERR_IN.table_name :='CENTER_IN_NOTIFY';
             r_ERR_IN.err_date :=SYSDATE ;
             r_ERR_IN.erp_doc_type :='PO ORDER HEADER INSERT';
             r_ERR_IN.wms_header_id :=NULL;
             r_ERR_IN.wms_line_id :=NULL;
             r_ERR_IN.erp_header_id :=CR_PO_HEADER.PO_HEADER_ID;
             r_ERR_IN.erp_line_id :=NULL;
             r_ERR_IN.erp_id :=NULL;
             r_ERR_IN.co_code :=L_CO_CODE;--'NS';
             r_ERR_IN.whse_code :=CR_PO_HEADER.WHSE_CODE;--'TCP1';
             r_ERR_IN.erp_no :=CR_PO_HEADER.PO_NUM;--'CP00-0001';
             r_ERR_IN.err_msg :=V_ERROR_MSG;--'ERRXXXXXXXXX';
             r_ERR_IN.remark :=' PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSE_CODE: '||CR_PO_HEADER.WHSE_CODE;--'XXXXXXXXXXX';
             r_ERR_IN.item_no :='';
             r_ERR_IN.lot_on  :='';
             r_ERR_IN.sublot_no  :='';
             r_ERR_IN.qty  :=NULL;          
                       
            -- L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；WHSEC_CODE: '||CR_PO_HEADER.WHSEC_CODE||' INSERT 异常记录表';
						L_RETURN_STATUS:='S';
						L_ERROR_MSG:='';
              CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                               L_RETURN_STATUS,
                               L_ERROR_MSG  );
              
            /*  IF L_RETURN_STATUS <>'S'
                THEN
                  V_RETURN_STATUS:=L_RETURN_STATUS;
                  V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                  RAISE ERR_OTHERS;
              END IF;*/
              END;
							
							RAISE ERR_OTHERS;
					END IF;
					END;
				
				L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||', INSERT WMS PO LINE LOOP START'; 
				FOR CR_PO_LINE in PO_LINE(CR_PO_HEADER.Po_Header_Id,CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID)
					LOOP
						
						BEGIN
						 r_IN_LINE_IN.C_IN_ERPOrder :=CR_PO_LINE.PO_LINE_ID;
						 r_IN_LINE_IN.C_IN_ERPRNO :=NULL;
						 r_IN_LINE_IN.C_IN_ID :=L_IN_HESDER_ID ;
						 r_IN_LINE_IN.C_IN_ProductId :=CR_PO_LINE.ITEM_ID;
						 r_IN_LINE_IN.C_IN_Batchno :='';
						 r_IN_LINE_IN.C_IN_ZBatchno :=CR_PO_LINE.SUBLOT_NO;--'';
						 r_IN_LINE_IN.C_IN_ITraycode :='';--'Y';--
						 r_IN_LINE_IN.C_IN_BOX :='';
						 r_IN_LINE_IN.C_IN_Unit :=CR_PO_LINE.ITEM_UM;
						 r_IN_LINE_IN.C_IN_State :=CR_PO_LINE.STATUS;
						 r_IN_LINE_IN.C_IN_BackedNum :=NULL;--TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS');
						 r_IN_LINE_IN.C_IN_Num :=CR_PO_LINE.QTY1;
						 r_IN_LINE_IN.C_IN_Real_Num :=NULL;
						 r_IN_LINE_IN.C_IN_Flag :=1 ;
						 r_IN_LINE_IN.C_IN_ReceiveTime :=CR_PO_LINE.REQ_DATE;--TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS');
						 r_IN_LINE_IN.C_IN_ERPTime :=SYSDATE;--TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS');
						 r_IN_LINE_IN.C_IN_WMSTime :=NULL;--TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS');
						 
							L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID||';INSERT WMS 入库中间表 行表';
							
							L_RETURN_STATUS:='S';
            L_ERROR_MSG:='';
							CUX_DEVELOP_NS_OPM_PKG.insert_IN_LINE(r_IN_LINE_IN,
															 L_RETURN_STATUS,
															 L_ERROR_MSG  );
					    
							IF L_RETURN_STATUS <>'S'
								THEN
									V_RETURN_STATUS:=L_RETURN_STATUS;
									V_ERROR_MSG:=L_ERROR_MSG;
									
									
            BEGIN
             r_ERR_IN.sys_code :='ERP';
             r_ERR_IN.table_name :='CENTER_IN_NOTIFYDETAIL';
             r_ERR_IN.err_date :=SYSDATE ;
             r_ERR_IN.erp_doc_type :='PO ORDER LINE INSERT';
             r_ERR_IN.wms_header_id :=L_IN_HESDER_ID;
             r_ERR_IN.wms_line_id :=NULL;
             r_ERR_IN.erp_header_id :=CR_PO_HEADER.PO_HEADER_ID;
             r_ERR_IN.erp_line_id :=CR_PO_LINE.PO_LINE_ID;
             r_ERR_IN.erp_id :=NULL;
             r_ERR_IN.co_code :=L_CO_CODE;--'NS';
             r_ERR_IN.whse_code :=CR_PO_HEADER.WHSE_CODE;--'TCP1';
             r_ERR_IN.erp_no :=CR_PO_HEADER.PO_NUM;--'CP00-0001';
             r_ERR_IN.err_msg :=V_ERROR_MSG;--'ERRXXXXXXXXX';
             r_ERR_IN.remark :='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID;--'XXXXXXXXXXX';
             r_ERR_IN.item_no :=CR_PO_LINE.ITEM_NO;
             r_ERR_IN.lot_on  :='';
             r_ERR_IN.sublot_no  :=CR_PO_LINE.SUBLOT_NO;--'';
             r_ERR_IN.qty  :=CR_PO_LINE.QTY1;          
                       
            -- L_TRANS:='PO_HEADER_ID: '||CR_PO_HEADER.PO_HEADER_ID||'；SHIP_TO_ORGANIZATION_ID: '||CR_PO_HEADER.SHIP_TO_ORGANIZATION_ID||' INSERT 异常记录表';
            L_RETURN_STATUS:='S';
            L_ERROR_MSG:='';
              CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                               L_RETURN_STATUS,
                               L_ERROR_MSG  );
              
            /*  IF L_RETURN_STATUS <>'S'
                THEN
                  V_RETURN_STATUS:=L_RETURN_STATUS;
                  V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                  RAISE ERR_OTHERS;
              END IF;*/
              END;
							
									RAISE ERR_OTHERS;
							END IF;
							END;
						
						end loop;--LINE LOOP END
				END IF;
				
			END LOOP;-- HEADER LOOP END
	  
    /*
    exception
      when others THEN
      V_ERROR_MSG := 'INSERT 异常';
      RAISE ERR_OTHERS;
    END;
    */
    V_RETURN_STATUS := NVL(L_RETURN_STATUS_U,'S');
    V_ERROR_MSG:=V_ERROR_MSG||' WMS PO ORDER INSERT 正常完成！';
		
			COMMIT;
   
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      /*L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出,主体传入参数：P_FROM_CO_CODE: '||P_FROM_CO_CODE||',P_TO_CO_CODE: '||P_TO_CO_CODE||',P_TYPE: '||P_TYPE||',P_PX_ID: '||P_PX_ID||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
      */  
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
    when others THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
  END;


/*###############################################################
  # NAME
  #  WMS_PO_RCV
  # SYNOPSIS
  #  proc WMS_PO_RCV
  # DESCRIPTION
  #  1、读取WMS结果，产生采购接收事务处理
  #  2、过程有 COMMIT
  #  3、抽取WMS 行表 C_IN_Flag=3 的采购接收的记录
  ###############################################################*/  
procedure WMS_PO_RCV(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2)
   AS
   
    --L_CO_CODE         VARCHAR2(10):='NS';--启用时要更改
    --L_RESULT    BOOLEAN;
    
    /*ERR_PARAMETER EXCEPTION;
    ERR_NO_DATA EXCEPTION;
    ERR_OTHERS EXCEPTION;*/
    L_TRANS                    VARCHAR2(1000);
    L_MSG     VARCHAR2(4000) := ' ';
    
    --V_RETURN_STATUS VARCHAR2(10):='S';
    --V_ERROR_MSG     VARCHAR2(4000);
    
    L_RETURN_STATUS_U VARCHAR2(10);
    
    cursor PO_RCV IS
    SELECT H.C_IN_ID,--  头序列
            H.C_IN_ERPID,-- ERP单据ID
            H.C_IN_ERPNO,-- ERP单据号
            H.C_IN_Type,--  单据类型
            H.C_IN_Date,--  单据日期
            H.C_IN_Warehouse,-- 仓库编号
            H.C_IN_Founder,-- 创建人
            H.c_in_customerid,--  供应商代码
            H.C_IN_CarrierName,-- 承运人
            H.C_IN_PutComplete,-- 作业标志
            H.C_IN_Flag H_C_IN_FLAG,--  单据标识
            H.C_IN_Time,--  写入时间
            H.C_IN_TrayNum,-- 子托盘数量
            l.c_in_no,--wms header_no
            l.c_in_order_no,--wms line_no
            L.C_IN_Order,-- 行序列
            L.C_IN_ERPOrder,--  ERP详细ID
            L.C_IN_ERPRNO,--  ERP接收号
          --  L.C_IN_ID,--  头序列
            L.C_IN_ProductId,-- 产品代码
            L.C_IN_Batchno,-- 批次号
            L.C_IN_ZBatchno,--  子批次
            L.C_IN_ITraycode,-- 是否有子托盘
            L.C_IN_BOX,--  规格
            L.C_IN_Unit,--  单位
            L.C_IN_State,-- 批次状态
            L.C_IN_BackedNum,-- 已退货数量
            L.C_IN_Num,-- 数量
            L.C_IN_Real_Num,--  实际数量
            L.C_IN_Flag ,--  单据标识
            L.C_IN_ReceiveTime,-- 收货时间
            L.C_IN_ERPTime,-- ERP写入时间
            L.C_IN_WMSTime-- WMS写入时间
            ,L.C_IN_VENDOR_LOT --ADD BY JSJ_HKX 2015-10-23 FOR 供应商批次
            ,L.C_IN_RECEIPTMANID --ADD BY JSJ_HKX 2015-10-23 FOR 实际收货人 USER_ID
    FROM CENTER_IN_NOTIFY H,CENTER_IN_NOTIFYDETAIL L
             WHERE H.C_IN_ID=L.C_IN_ID
             AND L.C_IN_Flag=3--WMS LINE 写入完成
             --AND H.C_IN_Flag=3--WMS HEADER 写入完成
             AND H.C_IN_Type=9--9：原辅料入库
;
    
    CR_PO_RCV PO_RCV%ROWTYPE;
    
    P_WHSE_CODE_IN     VARCHAR2(100);
    P_LOCATION_IN  VARCHAR2(100);
    V_WHSE_CODE_OUT  VARCHAR2(100);
    V_LOCATION_OUT      VARCHAR2(100);
    L_WHSE_CODE         VARCHAR2(100);
    L_ITEM_NO           VARCHAR(240);
    l_whse_flag         VARCHAR2(10);
    
    L_COUNT    NUMBER:=0;
    l_count_cr NUMBER:=0;
    L_RECEIPT_NUM  VARCHAR2(100);
    L_USER_NAME    VARCHAR2(100);
    L_LOCATION     VARCHAR2(100);
    L_REMARK       VARCHAR2(100):='WMS TO ERP PORC';
    
    L_RETURN_STATUS VARCHAR2(10):='S';
    L_ERROR_MSG     VARCHAR2(4000);
    r_ERR_IN  CUX_DEVELOP_NS_OPM_PKG.R_ERR;--异常记录表
    
    r_IN_HEADER_IN  CUX_DEVELOP_NS_OPM_PKG.R_IN_HEADER;--入库中间表 头表
    L_IN_HESDER_ID  NUMBER;--入库中间表 头表 返回的 头序列
    r_IN_LINE_IN  CUX_DEVELOP_NS_OPM_PKG.R_IN_LINE;--入库中间表 行表
    
    r_WMS_REL_IN  CUX_DEVELOP_NS_OPM_PKG.R_WMS_REL;--wms llpt 关联表
    l_lot_id       NUMBER;
  BEGIN
    L_TRANS:='CREATE PO RCV TRANS';
    
    L_TRANS:='OPEN CR_PO_RCV LOOP START';
    l_count_cr:=0;
    for CR_PO_RCV in PO_RCV
      LOOP
        l_count_cr:=l_count_cr+1;
       L_TRANS:='WMS 数据校验';
       
       BEGIN
        L_TRANS:='PO_HEADER_ID: '||CR_PO_RCV.C_IN_ERPID||'；WHSEC_CODE: '||CR_PO_RCV.C_IN_Warehouse||'；PO_LINE_ID: '||CR_PO_RCV.C_IN_ERPOrder||' 验证接收数量是否大于订单可接收数量';
        L_COUNT:=0;
        SELECT COUNT(*) 
        INTO L_COUNT
  FROM PO_HEADERS_ALL        H,
       PO_LINES_ALL          L,
       PO_LINE_LOCATIONS_ALL LL,
       --PO_DISTRIBUTIONS_ALL  D,
       MTL_SYSTEM_ITEMS_B B,
       GL_PLCY_MST        G,
       CUX_NS_WMS_ITEM_V  I
       ,ORG_ORGANIZATION_DEFINITIONS O
 WHERE H.PO_HEADER_ID = L.PO_HEADER_ID
   AND H.PO_HEADER_ID = LL.PO_HEADER_ID
   AND L.PO_LINE_ID = LL.PO_LINE_ID
      --AND L.PO_LINE_ID = D.PO_LINE_ID
      --AND L.PO_HEADER_ID = D.PO_HEADER_ID
   AND L.ITEM_ID = B.INVENTORY_ITEM_ID
   AND LL.SHIP_TO_ORGANIZATION_ID = B.ORGANIZATION_ID
   AND H.ORG_ID = G.ORG_ID
      --AND ll.quantity_received>0
      -- and H.PO_HEADER_ID = 92870--L_PO_HEADER_ID
      -- AND LL.SHIP_TO_ORGANIZATION_ID = L_SHIP_TO_ORGANIZATION_ID
   AND B.SEGMENT1 = I.ITEM_NO
   AND LL.SHIP_TO_ORGANIZATION_ID=O.ORGANIZATION_ID
      
   AND G.CO_CODE = L_CO_CODE--'GF' --'NS'
      --AND B.ORGANIZATION_ID=85
      
   AND L.CANCEL_FLAG <> 'Y'
   AND H.TYPE_LOOKUP_CODE = 'STANDARD'
   AND H.AUTHORIZATION_STATUS = 'APPROVED'
      
  -- AND H.LAST_UPDATE_DATE >NVL(L_REQ_DATE,L_INI_REQ_DATE)
   
   AND H.PO_HEADER_ID=CR_PO_RCV.C_IN_ERPID--L_PO_HEADER_ID--92906
   --AND LL.SHIP_TO_ORGANIZATION_ID=L_SHIP_TO_ORGANIZATION_ID--116
   AND  SUBSTR(O.ORGANIZATION_NAME,1,INSTR(O.ORGANIZATION_NAME,':',1)-1)=CR_PO_RCV.C_IN_Warehouse
   AND L.PO_LINE_ID = CR_PO_RCV.C_IN_ERPOrder
   
   --and LL.QUANTITY - LL.QUANTITY_RECEIVED-CR_PO_RCV.C_IN_Real_Num>0--未接收数量>实际接收数量 才能产生事务
   AND GMICUOM.UOM_CONVERSION(I.ITEM_ID,
                                                                            0,
                                                                            LL.QUANTITY -LL.QUANTITY_RECEIVED,
                                                                             L.UNIT_MEAS_LOOKUP_CODE,
                                                                            I.ITEM_UM,
                                                                            0)-CR_PO_RCV.C_IN_Real_Num>=0--未接收数量>实际接收数量 才能产生事务
   ;
   
   IF L_COUNT <1--未接收数量 < 实际接收数量 抛出异常
     THEN
        V_ERROR_MSG :=/*'PO_HEADER_ID: '||CR_PO_RCV.C_IN_ERPID||'；WHSEC_CODE: '||CR_PO_RCV.C_IN_Warehouse||'；PO_LINE_ID: '||CR_PO_RCV.C_IN_ERPOrder||*/' WMS实际接收数量：'||CR_PO_RCV.C_IN_Real_Num
||' 大于订单可接收数量，不能产生接收事务处理；';
               r_ERR_IN.sys_code :='ERP';
               r_ERR_IN.table_name :='CENTER_IN_NOTIFYDETAIL';
               r_ERR_IN.err_date :=SYSDATE ;
               r_ERR_IN.erp_doc_type :='PO RCV CREATE ERP TRANS ERR';
               r_ERR_IN.wms_header_id :=CR_PO_RCV.C_IN_ID;
               r_ERR_IN.wms_line_id :=CR_PO_RCV.C_IN_Order;
               r_ERR_IN.erp_header_id :=CR_PO_RCV.C_IN_ERPID;
               r_ERR_IN.erp_line_id :=CR_PO_RCV.C_IN_ERPOrder;
               r_ERR_IN.erp_id :=NULL;
               r_ERR_IN.co_code :=L_CO_CODE;--'NS';
               r_ERR_IN.whse_code :=CR_PO_RCV.C_IN_Warehouse;--'TCP1';
               r_ERR_IN.erp_no :=CR_PO_RCV.C_IN_ERPNO;--'CP00-0001';
               r_ERR_IN.item_no :=CR_PO_RCV.C_IN_ProductId;
               r_ERR_IN.lot_on  :=CR_PO_RCV.C_IN_Batchno;
               r_ERR_IN.sublot_no  :=CR_PO_RCV.C_IN_ZBatchno;
               r_ERR_IN.qty  :=CR_PO_RCV.C_IN_Real_Num;   --实际接收数量       
               
        RAISE ERR_OTHERS;
   END IF;
   END;
   
   BEGIN
   L_TRANS:='调用 WMS 采购接收接口程序：'||'PO_HEADER_ID: '||CR_PO_RCV.C_IN_ERPID||'；WHSEC_CODE: '||CR_PO_RCV.C_IN_Warehouse||'；PO_LINE_ID: '||CR_PO_RCV.C_IN_ERPOrder||'；PO_RCV_QTY: '||CR_PO_RCV.C_IN_Real_Num;
   IF CR_PO_RCV.C_IN_RECEIPTMANID IS NOT NULL--C_IN_CarrierName 是 仓管员 USER_ID--CHANGE BY JSJ_HKX 2015-10-23 FOR 实际收货人
     THEN
       BEGIN
       SELECT F.USER_NAME
       INTO L_USER_NAME
        FROM FND_USER F
       WHERE F.user_id=CR_PO_RCV.C_IN_RECEIPTMANID--C_IN_CarrierName --CHANGE BY JSJ_HKX 2015-10-23 FOR 实际收货人
       ;
       EXCEPTION
       WHEN others  THEN
         L_USER_NAME:=L_USER_NAME_WMS;
       END;
    ELSE
      L_USER_NAME:=L_USER_NAME_WMS;
   END IF;
   
   IF CR_PO_RCV.C_IN_Warehouse ='TCL1'
     THEN
       L_LOCATION:='PC-WMS';
     ELSIF CR_PO_RCV.C_IN_Warehouse ='TCP1'
       THEN
         L_LOCATION:='LT-WMS';
     ELSE
         L_LOCATION:='';
   END IF;
   /*
    L_TRANS:='采购接收的 WMS TO ERP 仓库逻辑转换'; 
       BEGIN
         l_whse_flag:=cux_develop_ns_opm_pkg.get_wmserp_whsecode(p_item_no => NULL,
                                                        p_item_id => CR_PO_RCV.C_IN_ProductId,--:p_item_id,
                                                        p_type => 'WMSTOERP',--:p_type,
                                                        p_whse_code_in =>CR_PO_RCV.C_IN_Warehouse,-- :p_whse_code_in,
                                                        p_location_in => L_LOCATION,--:p_location_in,
                                                        v_whse_code_out => l_whse_code,--:v_whse_code_out,
                                                        v_location_out =>L_LOCATION-- :v_location_out
                                                        );
       END;
   */
   V_RETURN_STATUS:='S';
   V_ERROR_MSG:='';
   WMS_PO_RCV_INF(
                  'D'--,P_TYPE       IN VARCHAR2--类型：D:采购接收；R：采购退货；
                  ,CR_PO_RCV.C_IN_ERPID--,P_PO_HEADER_ID  IN NUMBER
                  ,CR_PO_RCV.C_IN_ERPOrder--,P_PO_LINE_ID    IN NUMBER
                  ,CR_PO_RCV.C_IN_ProductId--,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,CR_PO_RCV.C_IN_Batchno--,P_LOT_NO     IN VARCHAR2
                  ,CR_PO_RCV.C_IN_ZBatchno--,P_SUBLOT_NO     IN VARCHAR2
                  ,CR_PO_RCV.C_IN_ReceiveTime--,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  /*,l_whse_code--*/,CR_PO_RCV.C_IN_Warehouse--,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,L_LOCATION--,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,CR_PO_RCV.C_IN_Real_Num--,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                  ,CR_PO_RCV.C_IN_Unit--,p_um         IN VARCHAR2--接收数量对应的单位
                  ,L_REMARK--,P_REMARK     IN VARCHAR2--备注
                  ,L_USER_NAME--,P_USER_NAME  IN VARCHAR2--用户名，可为空，空的时候默认：CY_ZCM
                  ,CR_PO_RCV.C_IN_VENDOR_LOT--要改成wms增加的字段--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,'WMS AUTO RCV'--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS-- OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG-- OUT varchar2--错误信息返回
                  ,L_RECEIPT_NUM--,V_RECEIPT_NUM   OUT NUMBER--返回接收号
    );
    
    L_RECEIPT_NUM:=CR_PO_RCV.C_IN_Warehouse||'-'||L_RECEIPT_NUM;
    
    IF V_RETURN_STATUS <>'S'
     THEN
        V_ERROR_MSG :=' 采购接收事务处理异常；'||V_ERROR_MSG;
               r_ERR_IN.sys_code :='ERP';
               r_ERR_IN.table_name :='CENTER_IN_NOTIFYDETAIL';
               r_ERR_IN.err_date :=SYSDATE ;
               r_ERR_IN.erp_doc_type :='PO RCV CREATE ERP TRANS ERR';
               r_ERR_IN.wms_header_id :=CR_PO_RCV.C_IN_ID;
               r_ERR_IN.wms_line_id :=CR_PO_RCV.C_IN_Order;
               r_ERR_IN.erp_header_id :=CR_PO_RCV.C_IN_ERPID;
               r_ERR_IN.erp_line_id :=CR_PO_RCV.C_IN_ERPOrder;
               r_ERR_IN.erp_id :=NULL;
               r_ERR_IN.co_code :=L_CO_CODE;--'NS';
               r_ERR_IN.whse_code :=CR_PO_RCV.C_IN_Warehouse;--'TCP1';
               r_ERR_IN.erp_no :=CR_PO_RCV.C_IN_ERPNO;--'CP00-0001';
               r_ERR_IN.item_no :=CR_PO_RCV.C_IN_ProductId;
               r_ERR_IN.lot_on  :=CR_PO_RCV.C_IN_Batchno;
               r_ERR_IN.sublot_no  :=CR_PO_RCV.C_IN_ZBatchno;
               r_ERR_IN.qty  :=CR_PO_RCV.C_IN_Real_Num;   --实际接收数量       
               
        RAISE ERR_OTHERS;
   END IF;
    
   --update wms 接口表 状态 和 接收号 L_RECEIPT_NUM 程序
   BEGIN
     L_TRANS:='UPDATE WMS 行状态 及 接收号：'||'WMS_HEADER_ID: '||CR_PO_RCV.C_IN_ID||'；WMS_LINE_ID: '||CR_PO_RCV.C_IN_Order;

     r_IN_LINE_IN.C_IN_Order :=CR_PO_RCV.C_IN_ORDER;
      --r_IN_LINE_IN.C_IN_ERPOrder :=CR_PO_RCV.C_IN_ERPOrder;
             r_IN_LINE_IN.C_IN_ERPRNO :=L_RECEIPT_NUM;--CR_PO_RCV.C_IN_ERPRNO;
             r_IN_LINE_IN.C_IN_ID :=CR_PO_RCV.C_IN_ID;
           --  r_IN_LINE_IN.C_IN_ProductId :=CR_PO_RCV.C_IN_ProductId;
             --r_IN_LINE_IN.C_IN_Batchno :=CR_PO_RCV.C_IN_Batchno;
            -- r_IN_LINE_IN.C_IN_ZBatchno :=CR_PO_RCV.C_IN_ZBatchno;
             --r_IN_LINE_IN.C_IN_ITraycode :=CR_PO_RCV.C_IN_ITraycode;
             --r_IN_LINE_IN.C_IN_Spec :=CR_PO_RCV.C_IN_Spec;
             --r_IN_LINE_IN.C_IN_Unit :=CR_PO_RCV.C_IN_Unit;
             --r_IN_LINE_IN.C_IN_State :=CR_PO_RCV.C_IN_State;
             --r_IN_LINE_IN.C_IN_BackedNum :=CR_PO_RCV.C_IN_BackedNum;
             --r_IN_LINE_IN.C_IN_Num :=CR_PO_RCV.C_IN_Num;
             --r_IN_LINE_IN.C_IN_Real_Num :=CR_PO_RCV.C_IN_Real_Num;
             --r_IN_LINE_IN.C_IN_Flag :=CR_PO_RCV.C_IN_Flag;
             --r_IN_LINE_IN.C_IN_ReceiveTime :=CR_PO_RCV.C_IN_ReceiveTime;
             --r_IN_LINE_IN.C_IN_ERPTime :=CR_PO_RCV.C_IN_ERPTime;
             --r_IN_LINE_IN.C_IN_WMSTime :=CR_PO_RCV.C_IN_WMSTime;
             
     CUX_DEVELOP_NS_OPM_PKG.UPDATE_IN_LINE(R_IN_LINE_IN,-- IN CUX_DEVELOP_NS_OPM_PKG.R_IN_LINE,
                    'A',--L_TYPE            IN VARCHAR2,--A:ALL 全部update为存入的值包括null；P:PART 只update传入的值不为空的值，传入为空的保持原值；Z:追加UPDATE,传入值不为空的数值或字符，合计或追加处理；
                    V_RETURN_STATUS ,--OUT VARCHAR2,
                    V_ERROR_MSG   --  OUT VARCHAR2
                    )
                    ;
     
     IF V_RETURN_STATUS <>'S'
     THEN
        V_ERROR_MSG :=' UPDATE WMS 行状态 及 接收号异常；'||V_ERROR_MSG;
               r_ERR_IN.sys_code :='ERP';
               r_ERR_IN.table_name :='CENTER_IN_NOTIFYDETAIL';
               r_ERR_IN.err_date :=SYSDATE ;
               r_ERR_IN.erp_doc_type :='PO RCV CREATE ERP TRANS ERR';
               r_ERR_IN.wms_header_id :=CR_PO_RCV.C_IN_ID;
               r_ERR_IN.wms_line_id :=CR_PO_RCV.C_IN_Order;
               r_ERR_IN.erp_header_id :=CR_PO_RCV.C_IN_ERPID;
               r_ERR_IN.erp_line_id :=CR_PO_RCV.C_IN_ERPOrder;
               r_ERR_IN.erp_id :=NULL;
               r_ERR_IN.co_code :=L_CO_CODE;--'NS';
               r_ERR_IN.whse_code :=CR_PO_RCV.C_IN_Warehouse;--'TCP1';
               r_ERR_IN.erp_no :=CR_PO_RCV.C_IN_ERPNO;--'CP00-0001';
               r_ERR_IN.item_no :=CR_PO_RCV.C_IN_ProductId;
               r_ERR_IN.lot_on  :=CR_PO_RCV.C_IN_Batchno;
               r_ERR_IN.sublot_no  :=CR_PO_RCV.C_IN_ZBatchno;
               r_ERR_IN.qty  :=CR_PO_RCV.C_IN_Real_Num;   --实际接收数量       
               
        RAISE ERR_OTHERS;
     END IF;
   END;
   
   END;
   
   BEGIN    
    L_TRANS:='写入wms llpt 关联表前获取lot_id;';
    SELECT DISTINCT L.LOT_ID
    INTO L_LOT_ID
    FROM IC_LOTS_MST L
    WHERE L.ITEM_ID=CR_PO_RCV.C_IN_PRODUCTID
    AND L.LOT_NO=CR_PO_RCV.C_IN_Batchno
    AND NVL(L.SUBLOT_NO,-1)=NVL(CR_PO_RCV.C_IN_ZBatchno,-1)
    ;
    EXCEPTION
      WHEN OTHERS THEN
        L_LOT_ID:=-1;
        V_ERROR_MSG:='写入wms llpt 关联表前获取lot_id 异常： '||V_ERROR_MSG;
        --RAISE ERR_OTHERS;
    END;

   BEGIN    
    L_TRANS:='INSERT WMS LLPT 关联表：'||'WMS_HEADER_ID: '||CR_PO_RCV.C_IN_ID||'；WMS_LINE_ID: '||CR_PO_RCV.C_IN_Order;

     --r_WMS_REL_IN.REL_ID =  ;
      r_WMS_REL_IN.SOURCE_WMS_TABLE :='CENTER_IN_NOTIFYDETAIL'  ;
      r_WMS_REL_IN.SOURE_CO_CODE := 'NS' ;
      r_WMS_REL_IN.TARGET_CO_CODE := 'NS' ;
      r_WMS_REL_IN.WMS_HEADER_NO := CR_PO_RCV.C_IN_NO ;
      r_WMS_REL_IN.WMS_LINE_NO :=  CR_PO_RCV.C_IN_ORDER_NO;
      r_WMS_REL_IN.WMS_HEADER_ID :=  CR_PO_RCV.C_IN_ID;
      r_WMS_REL_IN.WMS_LINE_ID := CR_PO_RCV.C_IN_ORDER ;
      r_WMS_REL_IN.ERP_HEADER_ID := CR_PO_RCV.C_IN_ERPID ;
      r_WMS_REL_IN.ERP_LINE_ID :=  CR_PO_RCV.C_IN_ERPORDER;
      r_WMS_REL_IN.ERP_DOC_ID :=  CUX_DEVELOP_NS_OPM_PKG.get_PORC_DOC_ID('NS',--P_CO_CODE       in VARCHAR2,
                            CR_PO_RCV.C_IN_ProductId,--P_ITEM_ID          IN NUMBER,
                            L_LOT_ID,--P_LOT_ID          IN NUMBER,
                            'D',--P_TYPE in VARCHAR2,--D,R
                            CR_PO_RCV.C_IN_Warehouse,--P_WHSE_CODE    in VARCHAR2,
                            SUBSTR(L_RECEIPT_NUM,INSTR(L_RECEIPT_NUM,'-',1,1)+1,LENGTH(L_RECEIPT_NUM)-INSTR(L_RECEIPT_NUM,'-',1,1)),--P_RCV_NO IN NUMBER,
                            CR_PO_RCV.C_IN_Real_Num,--P_QTY IN NUMBER,
                            CR_PO_RCV.C_IN_RECEIVETIME--P_TRANS_DATE IN DATE
                            );
      r_WMS_REL_IN.ERP_TRANS_ID := CUX_DEVELOP_NS_OPM_PKG.get_PX_PORC_TRANS_ID('NS',--P_CO_CODE       in VARCHAR2,
                            CR_PO_RCV.C_IN_ProductId,--P_ITEM_ID          IN NUMBER,
                            L_LOT_ID,--P_LOT_ID          IN NUMBER,
                            'D',--P_TYPE in VARCHAR2,--D,R
                            CR_PO_RCV.C_IN_Warehouse,--P_WHSE_CODE    in VARCHAR2,
                            SUBSTR(L_RECEIPT_NUM,INSTR(L_RECEIPT_NUM,'-',1,1)+1,LENGTH(L_RECEIPT_NUM)-INSTR(L_RECEIPT_NUM,'-',1,1)),--P_RCV_NO IN NUMBER,
                            CR_PO_RCV.C_IN_Real_Num,--P_QTY IN NUMBER,
                            CR_PO_RCV.C_IN_RECEIVETIME--P_TRANS_DATE IN DATE
                            );
      r_WMS_REL_IN.ERP_NO :=  SUBSTR(L_RECEIPT_NUM,INSTR(L_RECEIPT_NUM,'-',1,1)+1,LENGTH(L_RECEIPT_NUM)-INSTR(L_RECEIPT_NUM,'-',1,1));
      r_WMS_REL_IN.ERP_WHSE_CODE := CR_PO_RCV.C_IN_Warehouse;
      r_WMS_REL_IN.REL_TYPE := 'WMS' ;
      r_WMS_REL_IN.ERP_TYPE := 'PORC' ;
      r_WMS_REL_IN.DOC_TYPE := 'PORC' ;
      r_WMS_REL_IN.PX_DOC_TYPE := NULL ;
      r_WMS_REL_IN.PX_DOC_ID := NULL ;
      r_WMS_REL_IN.PX_TRANS_ID := NULL ;
      --r_WMS_REL_IN.creation_date :=  ;
      r_WMS_REL_IN.created_by :=  CR_PO_RCV.C_IN_CarrierName;
      --r_WMS_REL_IN.last_update_date :=  ;
      r_WMS_REL_IN.last_updated_by := CR_PO_RCV.C_IN_CarrierName ;
      --r_WMS_REL_IN.last_update_login :=  ;

             
     CUX_DEVELOP_NS_OPM_PKG.insert_WMS_REL(r_WMS_REL_IN, --IN CUX_DEVELOP_NS_OPM_PKG.R_WMS_REL,
                    V_RETURN_STATUS --OUT VARCHAR2,
                    ,V_ERROR_MSG     --OUT VARCHAR2
                    )
                    ;
     
     IF V_RETURN_STATUS <>'S'
     THEN
     
        RAISE ERR_OTHERS;
     END IF;
   END;
   
      END LOOP;-- CR_PO_RCV LOOP END
    
    /*
    exception
      when others THEN
      V_ERROR_MSG := 'INSERT 异常';
      RAISE ERR_OTHERS;
    END;
    */
    V_RETURN_STATUS := NVL(L_RETURN_STATUS_U,'S');
    V_ERROR_MSG:=V_ERROR_MSG||' WMS PO RCV TRANS 正常完成！完成数量：'||l_count_cr||'  ';
      
      COMMIT;
   
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      /*L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出,主体传入参数：P_FROM_CO_CODE: '||P_FROM_CO_CODE||',P_TO_CO_CODE: '||P_TO_CO_CODE||',P_TYPE: '||P_TYPE||',P_PX_ID: '||P_PX_ID||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
      */  
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
        --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RCV.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
        --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RCV.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RCV.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
    
    when others THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RCV.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
  END;
	
/*###############################################################
  # NAME
  #  WMS_PO_RETURN
  # SYNOPSIS
  #  proc WMS_PO_RETURN
  # DESCRIPTION
  #  1、读取WMS结果，产生采购退货事务处理
  #  2、过程有 COMMIT
  #  3、抽取WMS 出库接口表 行表 C_IN_Flag=3 的采购退货的记录
  ###############################################################*/  
procedure WMS_PO_RETURN(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2)
   AS
   
    --L_CO_CODE         VARCHAR2(10):='NS';--启用时要更改
    --L_RESULT    BOOLEAN;
    
    /*ERR_PARAMETER EXCEPTION;
    ERR_NO_DATA EXCEPTION;
    ERR_OTHERS EXCEPTION;*/
    L_TRANS                    VARCHAR2(1000);
    L_MSG     VARCHAR2(4000) := ' ';
    
    --V_RETURN_STATUS VARCHAR2(10):='S';
    --V_ERROR_MSG     VARCHAR2(4000);
    
    L_RETURN_STATUS_U VARCHAR2(10);
		L_OUT_RCV_NO      VARCHAR2(240);
		--L_OUT_WHSE_CODE   VARCHAR2(240);
    
    cursor PO_RET IS
    SELECT H.C_OUT_ID H_C_OUT_ID,-- 头序列
						H.C_OUT_NO H_C_OUT_NO,
						H.C_OUT_ERPID C_OUT_ERPID,-- ERP单据ID
						H.C_OUT_Type,-- 业务类型
						H.C_OUT_BillNo,-- 提货单号
						--H.C_OUT_BillType,-- 提货单据类型
						H.C_OUT_Date,-- 单据日期
						H.C_OUT_Warehouse,--  仓库编号
						H.C_OUT_Operator,-- 制单人
						H.C_OUT_IsAuto,-- 是否自动分配
						H.C_OUT_CarNo,--  车牌号
						H.C_OUT_Confirm,--  发货确认人
						H.C_OUT_TrayNum,--  子托盘数量
						H.C_OUT_Carrier,--  承运人
						H.C_OUT_Salesman,-- 结算人
						H.C_OUT_CustomerId,-- 客户代码
						H.C_OUT_PutComplete,--  出库完成标志
						H.C_OUT_Flag H_C_OUT_Flag,-- 单据标识
						H.C_OUT_Time,-- 写入时间
						H.C_CUSTOMER_TYPE,
						L.C_OUT_Order,--  行序列
						L.C_OUT_NO,--WMS headre_no
            l.C_OUT_ORDER_NO,--wms line_no
						L.C_OUT_ERPOrder,-- ERP详细ID
						L.C_OUT_ERPRNO C_OUT_ERPRNO,--  ERP接收号
						L.C_OUT_ID,-- 头序列
						L.C_OUT_ProductId,--  产品代码
						L.C_OUT_Batchno,--  批次号
						L.C_OUT_ZBatchno,-- 子批次
						L.C_OUT_ITraycode,--  是否有子托盘
						L.C_OUT_Spec,-- 规格
						L.C_OUT_Unit,-- 单位
						L.C_OUT_Num,--  数量
						L.C_OUT_Real_Num,-- 实际数量
						L.C_OUT_Platform,-- 月台号
						L.C_OUT_Flag,-- 单据标识
						L.C_OUT_ERPTime,--  ERP写入时间
						L.C_OUT_WMSTime--  WMS写入时间
						,L.C_OUT_XNO
    FROM CENTER_OUT_NOTIFY H,CENTER_OUT_NOTIFYDETAIL L
             WHERE H.C_OUT_ID=L.C_OUT_ID
             AND L.C_OUT_Flag=3--WMS LINE 写入完成
             --AND H.C_OUT_Flag=3--WMS HEADER 写入完成
             AND H.C_OUT_Type=3--3：退货出库
;
    
    CR_PO_RET PO_RET%ROWTYPE;
    
    L_COUNT    NUMBER:=0;
    L_RECEIPT_NUM  NUMBER;
    L_USER_NAME    VARCHAR2(100);
    L_LOCATION     VARCHAR2(100);
    L_REMARK       VARCHAR2(100):='WMS TO ERP PO RETURN';
		
		P_WHSE_CODE_IN     VARCHAR2(100);
    P_LOCATION_IN  VARCHAR2(100);
    V_WHSE_CODE_OUT  VARCHAR2(100);
    V_LOCATION_OUT      VARCHAR2(100);
		L_WHSE_CODE         VARCHAR2(100);
		L_ITEM_NO           VARCHAR(240);
		l_whse_flag         VARCHAR2(10);
    
    L_RETURN_STATUS VARCHAR2(10):='S';
    L_ERROR_MSG     VARCHAR2(4000);
    r_ERR_IN  CUX_DEVELOP_NS_OPM_PKG.R_ERR;--异常记录表
    
    r_OUT_HEADER_IN  CUX_DEVELOP_NS_OPM_PKG.R_OUT_HEADER;--出库中间表 头表
		L_OUT_HESDER_ID  NUMBER;--出库中间表 头表 返回的 头序列
		r_OUT_LINE_IN  CUX_DEVELOP_NS_OPM_PKG.R_OUT_LINE;--出库中间表 行表
    
    r_IN_HEADER_IN  CUX_DEVELOP_NS_OPM_PKG.R_IN_HEADER;--入库中间表 头表
    L_IN_HESDER_ID  NUMBER;--入库中间表 头表 返回的 头序列
    r_IN_LINE_IN  CUX_DEVELOP_NS_OPM_PKG.R_IN_LINE;--入库中间表 行表
		
		r_WMS_REL_IN  CUX_DEVELOP_NS_OPM_PKG.R_WMS_REL;--wms llpt 关联表
		l_lot_id       NUMBER;
  BEGIN
    L_TRANS:='CREATE PO RETURN TRANS';
    
    L_TRANS:='OPEN CR_PO_RET LOOP START';
    for CR_PO_RET in PO_RET
      LOOP
       L_TRANS:='WMS 数据校验';
       					
   BEGIN
   L_TRANS:='调用 WMS 采购退货接口程序：'||'PO_RCV_NO: '||CR_PO_RET.C_OUT_ERPRNO||'；WHSEC_CODE: '||CR_PO_RET.C_OUT_Warehouse||'；PO_ITEM_ID: '||CR_PO_RET.C_OUT_ProductId||'；PO_RET_QTY: '||CR_PO_RET.C_OUT_Real_Num||'；PO_LOT_NO: '||CR_PO_RET.C_OUT_Batchno||'；PO_SUBLOT_NO: '||CR_PO_RET.C_OUT_ZBatchno;
   IF CR_PO_RET.C_OUT_Confirm IS NOT NULL--C_OUT_CarrierName 是 仓管员 USER_ID
     THEN
       BEGIN
       SELECT F.USER_NAME
       INTO L_USER_NAME
        FROM FND_USER F
       WHERE F.user_id=CR_PO_RET.C_OUT_Confirm
       ;
       EXCEPTION
       WHEN others  THEN
         L_USER_NAME:=L_USER_NAME_WMS;
       END;
    ELSE
      L_USER_NAME:=L_USER_NAME_WMS;
   END IF;
   
   IF CR_PO_RET.C_OUT_Warehouse ='TCL1'
     THEN
       L_LOCATION:='PC-WMS';
     ELSIF CR_PO_RET.C_OUT_Warehouse ='TCP1'
       THEN
         L_LOCATION:='LT-WMS';
     ELSE
         L_LOCATION:='';
   END IF;
	 /*
	  L_TRANS:='采购接收的 WMS TO ERP 仓库逻辑转换'; 
       BEGIN
         l_whse_flag:=cux_develop_ns_opm_pkg.get_wmserp_whsecode(p_item_no => NULL,
                                                        p_item_id => CR_PO_RET.C_OUT_ProductId,--:p_item_id,
                                                        p_type => 'WMSTOERP',--:p_type,
                                                        p_whse_code_in =>CR_PO_RET.C_OUT_Warehouse,-- :p_whse_code_in,
                                                        p_location_in => L_LOCATION,--:p_location_in,
                                                        v_whse_code_out => l_whse_code,--:v_whse_code_out,
                                                        v_location_out =>L_LOCATION-- :v_location_out
                                                        );
       END;
	 */
	 L_OUT_RCV_NO:=CR_PO_RET.C_OUT_ERPRNO;
	 
   V_RETURN_STATUS:='S';
	 V_ERROR_MSG:='';
   WMS_PO_RCV_INF(
                  'R'--,P_TYPE       IN VARCHAR2--类型：D:采购接收；R：采购退货；
                  ,NULL--CR_PO_RET.C_OUT_ERPID--,P_PO_HEADER_ID  IN NUMBER
                  ,NULL--CR_PO_RET.C_OUT_ERPOrder--,P_PO_LINE_ID    IN NUMBER
                  ,CR_PO_RET.C_OUT_ProductId--,P_ITEM_ID    IN NUMBER--采购接收是净水的话要传入净水的item_id
                  ,CR_PO_RET.C_OUT_Batchno--,P_LOT_NO     IN VARCHAR2
                  ,CR_PO_RET.C_OUT_ZBatchno--,P_SUBLOT_NO     IN VARCHAR2
                  ,CR_PO_RET.C_OUT_Date--,P_TRANS_DATE IN DATE--采购接收或退货事务时间
                  /*,l_whse_code--*/,CR_PO_RET.C_OUT_Warehouse--,P_WHSE_CODE  IN VARCHAR2--接收仓库,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,L_LOCATION--,P_LOCATION   IN VARCHAR2--接收货位,采购退货不用这个参数，找接收号的仓库货位的库存退货
                  ,CR_PO_RET.C_OUT_Real_Num--,P_QTY        IN NUMBER--接收数量,退货数量，第一单位数量
                  ,CR_PO_RET.C_OUT_Unit--,p_um         IN VARCHAR2--接收数量对应的单位
                  ,L_REMARK--,P_REMARK     IN VARCHAR2--备注
                  ,L_USER_NAME--,P_USER_NAME  IN VARCHAR2--用户名，可为空，空的时候默认：CY_ZCM
                  ,''--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,'WMS AUTO RET'--add by jsj_hkx 2015-10-14 FOR 入库增加 供应商批次 信息
                  ,V_RETURN_STATUS-- OUT VARCHAR2--返回状态：S-正常完成，E-异常终止
                  ,V_ERROR_MSG-- OUT varchar2--错误信息返回
                  ,CR_PO_RET.C_OUT_ERPRNO--L_RECEIPT_NUM--,V_RECEIPT_NUM   IN NUMBER--传入接收号
    );
		
		
    
    IF V_RETURN_STATUS <>'S'
     THEN
        V_ERROR_MSG :=' 采购退货事务处理异常；'||V_ERROR_MSG;
               r_ERR_IN.sys_code :='ERP';
               r_ERR_IN.table_name :='CENTER_OUT_NOTIFYDETAIL';
               r_ERR_IN.err_date :=SYSDATE ;
               r_ERR_IN.erp_doc_type :='PO RETURN CREATE ERP TRANS ERR';
               r_ERR_IN.wms_header_id :=CR_PO_RET.C_OUT_ID;
               r_ERR_IN.wms_line_id :=CR_PO_RET.C_OUT_Order;
               r_ERR_IN.erp_header_id :=CR_PO_RET.C_OUT_ERPID;
               r_ERR_IN.erp_line_id :=CR_PO_RET.C_OUT_ERPOrder;
               r_ERR_IN.erp_id :=NULL;
               r_ERR_IN.co_code :=L_CO_CODE;--'NS';
               r_ERR_IN.whse_code :=CR_PO_RET.C_OUT_Warehouse;--'TCP1';
               r_ERR_IN.erp_no :=CR_PO_RET.C_OUT_ERPRNO;--'CP00-0001';
               r_ERR_IN.item_no :=CR_PO_RET.C_OUT_ProductId;
               r_ERR_IN.lot_on  :=CR_PO_RET.C_OUT_Batchno;
               r_ERR_IN.sublot_no  :=CR_PO_RET.C_OUT_ZBatchno;
               r_ERR_IN.qty  :=CR_PO_RET.C_OUT_Real_Num;   --实际接收数量       
               
        RAISE ERR_OTHERS;
   END IF;
    
   --update wms 出库接口表 状态  程序
	  BEGIN
     L_TRANS:='UPDATE WMS 行状态 及 接收号：'||'WMS_HEADER_ID: '||CR_PO_RET.C_OUT_ID||'；WMS_LINE_ID: '||CR_PO_RET.C_OUT_Order;

     R_OUT_LINE_IN.C_OUT_Order :=CR_PO_RET.C_OUT_ORDER;
      --R_OUT_LINE_IN.C_OUT_ERPOrder :=CR_PO_RET.C_OUT_ERPOrder;
            -- R_OUT_LINE_IN.C_OUT_ERPRNO :=CR_PO_RET.C_OUT_ERPRNO;
             R_OUT_LINE_IN.C_OUT_ID :=CR_PO_RET.C_OUT_ID;
           --  R_OUT_LINE_IN.C_OUT_ProductId :=CR_PO_RET.C_OUT_ProductId;
             --R_OUT_LINE_IN.C_OUT_Batchno :=CR_PO_RET.C_OUT_Batchno;
            -- R_OUT_LINE_IN.C_OUT_ZBatchno :=CR_PO_RET.C_OUT_ZBatchno;
             --R_OUT_LINE_IN.C_OUT_ITraycode :=CR_PO_RET.C_OUT_ITraycode;
             --R_OUT_LINE_IN.C_OUT_Spec :=CR_PO_RET.C_OUT_Spec;
             --R_OUT_LINE_IN.C_OUT_Unit :=CR_PO_RET.C_OUT_Unit;
             --R_OUT_LINE_IN.C_OUT_Num :=CR_PO_RET.C_OUT_Num;
             --R_OUT_LINE_IN.C_OUT_Real_Num :=CR_PO_RET.C_OUT_Real_Num;
             --R_OUT_LINE_IN.C_OUT_Platform :=CR_PO_RET.C_OUT_Platform;
             --R_OUT_LINE_IN.C_OUT_Flag :=CR_PO_RET.C_OUT_Flag;
             --R_OUT_LINE_IN.C_OUT_ERPTime :=CR_PO_RET.C_OUT_ERPTime;
             --R_OUT_LINE_IN.C_OUT_WMSTime :=CR_PO_RET.C_OUT_WMSTime;
             
     CUX_DEVELOP_NS_OPM_PKG.UPDATE_OUT_LINE(R_OUT_LINE_IN,-- IN CUX_DEVELOP_NS_OPM_PKG.R_IN_LINE,
                    V_RETURN_STATUS ,--OUT VARCHAR2,
                    V_ERROR_MSG   --  OUT VARCHAR2
                    )
                    ;
     
     IF V_RETURN_STATUS <>'S'
     THEN
        V_ERROR_MSG :=' UPDATE WMS 行状态 异常；'||V_ERROR_MSG;
               r_ERR_IN.sys_code :='ERP';
               r_ERR_IN.table_name :='CENTER_OUT_NOTIFYDETAIL';
               r_ERR_IN.err_date :=SYSDATE ;
               r_ERR_IN.erp_doc_type :='UPDATE WMS OUT LINE STATE ERR';
               r_ERR_IN.wms_header_id :=CR_PO_RET.C_OUT_ID;
               r_ERR_IN.wms_line_id :=CR_PO_RET.C_OUT_Order;
               r_ERR_IN.erp_header_id :=CR_PO_RET.C_OUT_ERPID;
               r_ERR_IN.erp_line_id :=CR_PO_RET.C_OUT_ERPOrder;
               r_ERR_IN.erp_id :=NULL;
               r_ERR_IN.co_code :=L_CO_CODE;--'NS';
               r_ERR_IN.whse_code :=CR_PO_RET.C_OUT_Warehouse;--'TCP1';
               r_ERR_IN.erp_no :=CR_PO_RET.C_OUT_ERPRNO;--'CP00-0001';
               r_ERR_IN.item_no :=CR_PO_RET.C_OUT_ProductId;
               r_ERR_IN.lot_on  :=CR_PO_RET.C_OUT_Batchno;
               r_ERR_IN.sublot_no  :=CR_PO_RET.C_OUT_ZBatchno;
               r_ERR_IN.qty  :=CR_PO_RET.C_OUT_Real_Num;   --实际接收数量         
               
        RAISE ERR_OTHERS;
     END IF;
   END;
	 
	 BEGIN
		 L_TRANS:='获取 wms入库中间表的 WMS_LINE_ID：'||' ERP_RCV_NO: '||CR_PO_RET.C_OUT_ERPRNO||' WHSE_CODE: '||CR_PO_RET.C_OUT_Warehouse||' ITEM_ID: '||CR_PO_RET.C_OUT_ProductId||' LOT_NO: '||CR_PO_RET.C_OUT_Batchno||' SUBLOT_NO: '||CR_PO_RET.C_OUT_ZBatchno;
		 
   SELECT L.C_IN_Order
	 INTO r_IN_LINE_IN.C_IN_Order
	 FROM CENTER_IN_NOTIFY H,CENTER_IN_NOTIFYDETAIL L
	 WHERE H.C_IN_ID=L.C_IN_ID
	 AND L.C_IN_Flag=4
	 AND L.C_IN_ERPRNO=L_OUT_RCV_NO-- CR_PO_RET.C_OUT_ERPRNO
	 --AND H.C_IN_Warehouse=CR_PO_RET.C_OUT_Warehouse
	 AND L.C_IN_ProductId=CR_PO_RET.C_OUT_ProductId
	 AND L.C_IN_Batchno=CR_PO_RET.C_OUT_Batchno
	 AND L.C_IN_ZBatchno=CR_PO_RET.C_OUT_ZBatchno
	 ;
	 exception
          when others THEN
          V_ERROR_MSG := 'UPDATE WMS 入库表 行表 追加已接收数量，获取 wms入库中间表的 WMS_LINE_ID  异常';
	  RAISE ERR_OTHERS;
	 END;
	 
   BEGIN
     L_TRANS:='UPDATE WMS 入库表 行表 追加已接收数量：'||'；WMS_LINE_ID: '||r_IN_LINE_IN.C_IN_Order;
    
	V_RETURN_STATUS:=NULL;
  V_ERROR_MSG:=NULL;
										
	--r_IN_LINE_IN.C_IN_Order :=CR_PO_RCV.C_IN_ORDER;
   -- r_IN_LINE_IN.C_IN_ERPOrder :=CR_PO_RCV.C_IN_ERPOrder;
            -- r_IN_LINE_IN.C_IN_ERPRNO :=L_RECEIPT_NUM;--CR_PO_RCV.C_IN_ERPRNO;
         --    r_IN_LINE_IN.C_IN_ID :=CR_PO_RCV.C_IN_ID;
           --  r_IN_LINE_IN.C_IN_ProductId :=CR_PO_RCV.C_IN_ProductId;
             --r_IN_LINE_IN.C_IN_Batchno :=CR_PO_RCV.C_IN_Batchno;
            -- r_IN_LINE_IN.C_IN_ZBatchno :=CR_PO_RCV.C_IN_ZBatchno;
             --r_IN_LINE_IN.C_IN_ITraycode :=CR_PO_RCV.C_IN_ITraycode;
             --r_IN_LINE_IN.C_IN_Spec :=CR_PO_RCV.C_IN_Spec;
             --r_IN_LINE_IN.C_IN_Unit :=CR_PO_RCV.C_IN_Unit;
             --r_IN_LINE_IN.C_IN_State :=CR_PO_RCV.C_IN_State;
             r_IN_LINE_IN.C_IN_BackedNum :=CR_PO_RET.C_OUT_Real_Num;
             --r_IN_LINE_IN.C_IN_Num :=CR_PO_RCV.C_IN_Num;
             --r_IN_LINE_IN.C_IN_Real_Num :=CR_PO_RCV.C_IN_Real_Num;
             --r_IN_LINE_IN.C_IN_Flag :=CR_PO_RCV.C_IN_Flag;
             --r_IN_LINE_IN.C_IN_ReceiveTime :=CR_PO_RCV.C_IN_ReceiveTime;
             --r_IN_LINE_IN.C_IN_ERPTime :=CR_PO_RCV.C_IN_ERPTime;
             --r_IN_LINE_IN.C_IN_WMSTime :=CR_PO_RCV.C_IN_WMSTime;
            
     CUX_DEVELOP_NS_OPM_PKG.UPDATE_IN_LINE(r_IN_LINE_IN,-- IN CUX_DEVELOP_NS_OPM_PKG.R_IN_LINE,
                    'Z',--L_TYPE            IN VARCHAR2,--A:ALL 全部update为存入的值包括null；P:PART 只update传入的值不为空的值，传入为空的保持原值；Z:追加UPDATE,传入值不为空的数值或字符，合计或追加处理；
                    V_RETURN_STATUS ,--OUT VARCHAR2,
                    V_ERROR_MSG   --  OUT VARCHAR2
                    )
                    ;
     
     IF V_RETURN_STATUS <>'S'
     THEN
        V_ERROR_MSG :=' UPDATE WMS 入库中间表 行表 追加已退货数量 异常；'||V_ERROR_MSG;
               r_ERR_IN.sys_code :='ERP';
               r_ERR_IN.table_name :='CENTER_IN_NOTIFYDETAIL';
               r_ERR_IN.err_date :=SYSDATE ;
               r_ERR_IN.erp_doc_type :='PO RETURN CREATE ERP TRANS ERR';
               r_ERR_IN.wms_header_id :=NULL;--CR_PO_RET.C_OUT_ID;
               r_ERR_IN.wms_line_id :=r_IN_LINE_IN.C_IN_Order;
               r_ERR_IN.erp_header_id :=CR_PO_RET.C_OUT_ERPID;
               r_ERR_IN.erp_line_id :=CR_PO_RET.C_OUT_ERPOrder;
               r_ERR_IN.erp_id :=NULL;
               r_ERR_IN.co_code :=L_CO_CODE;--'NS';
               r_ERR_IN.whse_code :=CR_PO_RET.C_OUT_Warehouse;--'TCP1';
               r_ERR_IN.erp_no :=CR_PO_RET.C_OUT_ERPRNO;--'CP00-0001';
               r_ERR_IN.item_no :=CR_PO_RET.C_OUT_ProductId;
               r_ERR_IN.lot_on  :=CR_PO_RET.C_OUT_Batchno;
               r_ERR_IN.sublot_no  :=CR_PO_RET.C_OUT_ZBatchno;
               r_ERR_IN.qty  :=CR_PO_RET.C_OUT_Real_Num;   --实际接收数量       
               
        RAISE ERR_OTHERS;
     END IF;
   END;
   
   END;
	 
	  
   BEGIN    
    L_TRANS:='写入wms llpt 关联表前获取lot_id;';
    SELECT DISTINCT L.LOT_ID
    INTO L_LOT_ID
    FROM IC_LOTS_MST L
    WHERE L.ITEM_ID=CR_PO_RET.C_OUT_PRODUCTID
    AND L.LOT_NO=CR_PO_RET.C_OUT_Batchno
    AND NVL(L.SUBLOT_NO,-1)=NVL(CR_PO_RET.C_OUT_ZBatchno,-1)
    ;
    EXCEPTION
      WHEN OTHERS THEN
        L_LOT_ID:=-1;
        V_ERROR_MSG:='写入wms llpt 关联表前获取lot_id 异常： '||V_ERROR_MSG;
        --RAISE ERR_OTHERS;
    END;

   BEGIN    
    L_TRANS:='INSERT WMD LLPT 关联表：'||'WMS_HEADER_ID: '||CR_PO_RET.C_OUT_ID||'；WMS_LINE_ID: '||CR_PO_RET.C_OUT_Order;

     --r_WMS_REL_IN.REL_ID =  ;
      r_WMS_REL_IN.SOURCE_WMS_TABLE :='CENTER_OUT_NOTIFYDETAIL'  ;
      r_WMS_REL_IN.SOURE_CO_CODE := 'NS' ;
      r_WMS_REL_IN.TARGET_CO_CODE := 'NS' ;
      r_WMS_REL_IN.WMS_HEADER_NO := CR_PO_RET.C_OUT_NO ;
      r_WMS_REL_IN.WMS_LINE_NO :=  CR_PO_RET.C_OUT_ORDER_NO;
      r_WMS_REL_IN.WMS_HEADER_ID :=  CR_PO_RET.C_OUT_ID;
      r_WMS_REL_IN.WMS_LINE_ID := CR_PO_RET.C_OUT_ORDER ;
      r_WMS_REL_IN.ERP_HEADER_ID := CR_PO_RET.C_OUT_ERPID ;--可能是 NULL
      r_WMS_REL_IN.ERP_LINE_ID :=  CR_PO_RET.C_OUT_ERPORDER;--可能是 NULL
			r_WMS_REL_IN.ERP_NO :=  --SUBSTR(CR_PO_RET.C_OUT_ERPRNO,INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)+1,LENGTH(CR_PO_RET.C_OUT_ERPRNO)-INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1));
			SUBSTR(L_OUT_RCV_NO,INSTR(L_OUT_RCV_NO,'-',1,1)+1,LENGTH(L_OUT_RCV_NO)-INSTR(L_OUT_RCV_NO,'-',1,1));
      r_WMS_REL_IN.ERP_WHSE_CODE :=--SUBSTR(CR_PO_RET.C_OUT_ERPRNO,1,INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1));-- CR_PO_RET.C_OUT_Warehouse;
			SUBSTR(L_OUT_RCV_NO,1,INSTR(L_OUT_RCV_NO,'-',1,1)-1);
			
			
      r_WMS_REL_IN.ERP_DOC_ID :=  CUX_DEVELOP_NS_OPM_PKG.get_PORC_DOC_ID('NS',--P_CO_CODE       in VARCHAR2,
                            CR_PO_RET.C_OUT_ProductId,--P_ITEM_ID          IN NUMBER,
                            L_LOT_ID,--P_LOT_ID          IN NUMBER,
                            'R',--P_TYPE in VARCHAR2,--D,R
                            ---SUBSTR(CR_PO_RET.C_OUT_ERPRNO,1,INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)),--CR_PO_RET.C_OUT_Warehouse,--P_WHSE_CODE    in VARCHAR2,
														r_WMS_REL_IN.ERP_WHSE_CODE,--SUBSTR(L_OUT_RCV_NO,1,INSTR(L_OUT_RCV_NO,'-',1,1)),
                            --SUBSTR(CR_PO_RET.C_OUT_ERPRNO,INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)+1,LENGTH(CR_PO_RET.C_OUT_ERPRNO)-INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)),--P_RCV_NO IN NUMBER,
														r_WMS_REL_IN.ERP_no,--SUBSTR(L_OUT_RCV_NO,INSTR(L_OUT_RCV_NO,'-',1,1)+1,LENGTH(L_OUT_RCV_NO)-INSTR(L_OUT_RCV_NO,'-',1,1)),
                            CR_PO_RET.C_OUT_Real_Num,--P_QTY IN NUMBER,
                            CR_PO_RET.C_OUT_Date--P_TRANS_DATE IN DATE
                            );
														
      r_WMS_REL_IN.ERP_TRANS_ID := CUX_DEVELOP_NS_OPM_PKG.get_PX_PORC_TRANS_ID('NS',--P_CO_CODE       in VARCHAR2,
                            CR_PO_RET.C_OUT_ProductId,--P_ITEM_ID          IN NUMBER,
                            L_LOT_ID,--P_LOT_ID          IN NUMBER,
                            'R',--P_TYPE in VARCHAR2,--D,R
                             --SUBSTR(CR_PO_RET.C_OUT_ERPRNO,1,INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)),--P_WHSE_CODE    in VARCHAR2,
														 r_WMS_REL_IN.ERP_WHSE_CODE,--SUBSTR(L_OUT_RCV_NO,1,INSTR(L_OUT_RCV_NO,'-',1,1)),
                             --SUBSTR(CR_PO_RET.C_OUT_ERPRNO,INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)+1,LENGTH(CR_PO_RET.C_OUT_ERPRNO)-INSTR(CR_PO_RET.C_OUT_ERPRNO,'-',1,1)),--P_RCV_NO IN NUMBER,
														 r_WMS_REL_IN.ERP_no,--SUBSTR(L_OUT_RCV_NO,INSTR(L_OUT_RCV_NO,'-',1,1)+1,LENGTH(L_OUT_RCV_NO)-INSTR(L_OUT_RCV_NO,'-',1,1)),
                            CR_PO_RET.C_OUT_Real_Num,--P_QTY IN NUMBER,
                            CR_PO_RET.C_OUT_Date--P_TRANS_DATE IN DATE
                            );
      
      r_WMS_REL_IN.REL_TYPE := 'WMS' ;
      r_WMS_REL_IN.ERP_TYPE := 'PORC RETURN' ;
      r_WMS_REL_IN.DOC_TYPE := 'PORC' ;
      r_WMS_REL_IN.PX_DOC_TYPE := NULL ;
      r_WMS_REL_IN.PX_DOC_ID := NULL ;
      r_WMS_REL_IN.PX_TRANS_ID := NULL ;
      --r_WMS_REL_IN.creation_date :=  ;
      r_WMS_REL_IN.created_by :=  CR_PO_RET.C_OUT_Confirm;
      --r_WMS_REL_IN.last_update_date :=  ;
      r_WMS_REL_IN.last_updated_by :=CR_PO_RET.C_OUT_Confirm ;
      --r_WMS_REL_IN.last_update_login :=  ;

             
     CUX_DEVELOP_NS_OPM_PKG.insert_WMS_REL(r_WMS_REL_IN, --IN CUX_DEVELOP_NS_OPM_PKG.R_WMS_REL,
                    V_RETURN_STATUS --OUT VARCHAR2,
                    ,V_ERROR_MSG     --OUT VARCHAR2
                    )
                    ;
     
     IF V_RETURN_STATUS <>'S'
     THEN
     
        RAISE ERR_OTHERS;
     END IF;
   END;
        
      END LOOP;-- CR_PO_RET LOOP END
    
    /*
    exception
      when others THEN
      V_ERROR_MSG := 'INSERT 异常';
      RAISE ERR_OTHERS;
    END;
    */
    V_RETURN_STATUS := NVL(L_RETURN_STATUS_U,'S');
    V_ERROR_MSG:=V_ERROR_MSG||' WMS PO RETURN TRANS 正常完成！';
      
      COMMIT;
   
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      /*L_MSG:=L_MSG||';'||L_TRANS||' 过程异常退出,主体传入参数：P_FROM_CO_CODE: '||P_FROM_CO_CODE||',P_TO_CO_CODE: '||P_TO_CO_CODE||',P_TYPE: '||P_TYPE||',P_PX_ID: '||P_PX_ID||',P_ITEM_ID: '||P_ITEM_ID||',P_LOT_ID: '||P_LOT_ID||',P_TRANS_DATE: '||P_TRANS_DATE||',P_WHSE_CODE: '||P_WHSE_CODE||',P_LOCATION: '||P_LOCATION||',P_QTY: '||P_QTY||',p_um: '||p_um||',P_REMARK: '||P_REMARK||',P_USER_NAME: '||P_USER_NAME;--||',l_type: '||l_type;
        V_ERROR_MSG:=L_MSG||'  '|| SQLERRM;
      */  
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
        --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RET.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
        --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RET.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RET.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
    
    when others THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      --------------写入异常记录表 START---------------------------
       BEGIN
               r_ERR_IN.err_msg :=V_ERROR_MSG;
               r_ERR_IN.remark :=L_TRANS;
               
              -- L_TRANS:='PO_LINE_ID: '||CR_PO_RET.PO_LINE_ID||'；'||L_TRANS;
              L_RETURN_STATUS:='S';
              L_ERROR_MSG:='';
                CUX_DEVELOP_NS_OPM_PKG.insert_err(r_ERR_IN,
                                 L_RETURN_STATUS,
                                 L_ERROR_MSG  );
                
              /*  IF L_RETURN_STATUS <>'S'
                  THEN
                    V_RETURN_STATUS:=L_RETURN_STATUS;
                    V_ERROR_MSG:=L_ERROR_MSG||';'||V_ERROR_MSG;
                    RAISE ERR_OTHERS;
                END IF;*/
                END;
      COMMIT;
      --------------写入异常记录表 END---------------------------
  END;
  
  /*===================WMS PO 接口 END==================*/
	
	function GET_RETURN_QTY(P_item_ID in NUMBER,
		                                p_rcv_no IN VARCHAR2-- 长这样：TCL1-111
		) return NUMBER is
    --L_COUNT       number;
    L_RETURN_QTY NUMBER;
  begin
    begin
      SELECT -SUM(p.trans_qty)
			INTO L_RETURN_QTY
  FROM PO_HEADERS_ALL       PHA,
       RCV_TRANSACTIONS     RT,
       PO_VENDORS           PV,
       PO_LINES_ALL         PLA,
       RCV_SHIPMENT_HEADERS RSH,
       IC_TRAN_PND          P,
       IC_LOTS_MST          L/*,
       PO_HEADERS_RFQQT_V   BJH*/

 WHERE RT.PO_LINE_ID = PLA.PO_LINE_ID
   --AND PLA.FROM_HEADER_ID = BJH.PO_HEADER_ID(+)
   AND P.ITEM_ID = L.ITEM_ID
   AND P.LOT_ID = L.LOT_ID
   AND RT.SHIPMENT_HEADER_ID = RSH.SHIPMENT_HEADER_ID
   AND PLA.PO_HEADER_ID = PHA.PO_HEADER_ID
   AND PHA.VENDOR_ID = PV.VENDOR_ID
  /* AND RT.TRANSACTION_TYPE IN ('DELIVER',
                               'CORRECT', \* 'RETURN TO RECEIVING',*\
                               'RETURN TO VENDOR')
   */
  -- AND TO_CHAR(RT.TRANSACTION_DATE, 'YYYYMM') LIKE &YYYYMM --'%2010%' --= '05-2010' 
      /* AND PLA.ORG_ID = \*:p_org_id  --*\
      '123'*/
   AND RT.SHIPMENT_HEADER_ID = P.DOC_ID
   AND P.LINE_ID = RT.TRANSACTION_ID
   AND P.DOC_TYPE = 'PORC'
   AND P.DELETE_MARK = 0
   AND P.COMPLETED_IND = 1
      
      --AND P.TRANS_ID=12447163
      
      /*  AND (PLA.ITEM_DESCRIPTION LIKE '%600ml一级专用白色玻璃瓶(新瓶型)%' OR
      PLA.ITEM_DESCRIPTION LIKE '%500ml一级专用青色旧玻璃瓶(新瓶型2)%' OR
      PLA.ITEM_DESCRIPTION LIKE '%500ml二级专用青色旧玻璃瓶_新瓶型2%' OR
      PLA.ITEM_DESCRIPTION LIKE '%600ml一级专用青色玻璃瓶(新瓶型)%')*/
      --AND P.LOCATION LIKE 'LS%'
      
      /*  AND (SELECT MSI.SEGMENT1
                FROM MTL_SYSTEM_ITEMS_B MSI
               WHERE MSI.INVENTORY_ITEM_ID = PLA.ITEM_ID
                 AND ROWNUM = 1)
                  --IN ( \*'03-03-500-07-1-0',*\'03-03-355-10-4-0'\*,'03-03-355-28-2-1','03-03-355-20-2-0'*\)
      --IN ('03-03-355-10-4-0')
      IN ('03-03-355-20-2-0')*/
      
   --AND PHA.SEGMENT1 LIKE &PO_NUMBER --'5042'
  
  /* AND (SELECT MSI.SEGMENT1
          FROM MTL_SYSTEM_ITEMS_B MSI
         WHERE MSI.INVENTORY_ITEM_ID = PLA.ITEM_ID
           AND ROWNUM = 1) LIKE &ITEM_NO*/
    
	AND RT.TRANSACTION_TYPE = 'RETURN TO VENDOR'
   AND P.CO_CODE ='NS'--LIKE &CO_CODE
   AND P.WHSE_CODE =SUBSTR(p_rcv_no,1,INSTR(p_rcv_no,'-',1,1)-1)--LIKE &WHSE_CODE
   AND p.item_id =P_ITEM_ID --LIKE  &p_item_id
	  AND RSH.RECEIPT_NUM =SUBSTR(p_rcv_no,INSTR(p_rcv_no,'-',1,1)+1,LENGTH(p_rcv_no)-INSTR(p_rcv_no,'-',1,1))--LIKE &RCV_NUMBER
   --AND PV.VENDOR_NAME =/*'波士胶芬得利(中国)粘合剂有限公司'--*/'波士胶芬得利（中国）粘合剂有限公司'
  
   ;
      --commit;
      return L_RETURN_QTY;
    exception
      when others then
        --rollback;
        return null;
    end;
  end;
	
	


/*###############################################################
  # NAME
  #  UPDATE_WMS_IN_RET_QTY
  # SYNOPSIS
  #  proc UPDATE_WMS_IN_RET_QTY
  # DESCRIPTION
  #  1、周期 定时  UPDATE  UPDATE_WMS_IN_RET_QTY.C_IN_BackedNum 退货数量
  #  2、每小时upadte一次
  ###############################################################*/  
/*procedure UPDATE_WMS_IN_RET_QTY(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2)
   AS
   
   
    \*ERR_PARAMETER EXCEPTION;
    ERR_NO_DATA EXCEPTION;
    ERR_OTHERS EXCEPTION;*\
    L_TRANS                    VARCHAR2(1000);
    L_MSG     VARCHAR2(4000) := ' ';
    
    --V_RETURN_STATUS VARCHAR2(10):='S';
    --V_ERROR_MSG     VARCHAR2(4000);
    
    L_RETURN_STATUS_U VARCHAR2(10);
    
   
    L_REMARK       VARCHAR2(100):='UPDATE WMS RET QTY';
    
    L_RETURN_STATUS VARCHAR2(10):='S';
    L_ERROR_MSG     VARCHAR2(4000);
    
		cursor PO_RET IS
    SELECT A.C_IN_Order,C_IN_BackedNum,C_IN_ProductId,C_IN_ERPRNO FROM CENTER_IN_NOTIFYDETAIL A,CENTER_IN_NOTIFY H
		WHERE A.C_IN_ID=H.C_IN_ID
		AND H.C_IN_Type=9
		AND A.C_IN_ERPRNO IS NOT NULL
		AND A.C_IN_BackedNum <> NVL(GET_RETURN_QTY(A.C_IN_ProductId,A.C_IN_ERPRNO),C_IN_BackedNum)
	\*	
		( SELECT -SUM(p.trans_qty)
			INTO L_RETURN_QTY
  FROM PO_HEADERS_ALL       PHA,
       RCV_TRANSACTIONS     RT,
       PO_VENDORS           PV,
       PO_LINES_ALL         PLA,
       RCV_SHIPMENT_HEADERS RSH,
       IC_TRAN_PND          P,
       IC_LOTS_MST          L\*,
       PO_HEADERS_RFQQT_V   BJH*\

 WHERE RT.PO_LINE_ID = PLA.PO_LINE_ID
   --AND PLA.FROM_HEADER_ID = BJH.PO_HEADER_ID(+)
   AND P.ITEM_ID = L.ITEM_ID
   AND P.LOT_ID = L.LOT_ID
   AND RT.SHIPMENT_HEADER_ID = RSH.SHIPMENT_HEADER_ID
   AND PLA.PO_HEADER_ID = PHA.PO_HEADER_ID
   AND PHA.VENDOR_ID = PV.VENDOR_ID
  \* AND RT.TRANSACTION_TYPE IN ('DELIVER',
                               'CORRECT', \* 'RETURN TO RECEIVING',*\
                               'RETURN TO VENDOR')
   *\
  -- AND TO_CHAR(RT.TRANSACTION_DATE, 'YYYYMM') LIKE &YYYYMM --'%2010%' --= '05-2010' 
      \* AND PLA.ORG_ID = \*:p_org_id  --*\
      '123'*\
   AND RT.SHIPMENT_HEADER_ID = P.DOC_ID
   AND P.LINE_ID = RT.TRANSACTION_ID
   AND P.DOC_TYPE = 'PORC'
   AND P.DELETE_MARK = 0
   AND P.COMPLETED_IND = 1
      
      --AND P.TRANS_ID=12447163
      
      \*  AND (PLA.ITEM_DESCRIPTION LIKE '%600ml一级专用白色玻璃瓶(新瓶型)%' OR
      PLA.ITEM_DESCRIPTION LIKE '%500ml一级专用青色旧玻璃瓶(新瓶型2)%' OR
      PLA.ITEM_DESCRIPTION LIKE '%500ml二级专用青色旧玻璃瓶_新瓶型2%' OR
      PLA.ITEM_DESCRIPTION LIKE '%600ml一级专用青色玻璃瓶(新瓶型)%')*\
      --AND P.LOCATION LIKE 'LS%'
      
      \*  AND (SELECT MSI.SEGMENT1
                FROM MTL_SYSTEM_ITEMS_B MSI
               WHERE MSI.INVENTORY_ITEM_ID = PLA.ITEM_ID
                 AND ROWNUM = 1)
                  --IN ( \*'03-03-500-07-1-0',*\'03-03-355-10-4-0'\*,'03-03-355-28-2-1','03-03-355-20-2-0'*\)
      --IN ('03-03-355-10-4-0')
      IN ('03-03-355-20-2-0')*\
      
   --AND PHA.SEGMENT1 LIKE &PO_NUMBER --'5042'
  
  \* AND (SELECT MSI.SEGMENT1
          FROM MTL_SYSTEM_ITEMS_B MSI
         WHERE MSI.INVENTORY_ITEM_ID = PLA.ITEM_ID
           AND ROWNUM = 1) LIKE &ITEM_NO*\
    
	AND RT.TRANSACTION_TYPE = 'RETURN TO VENDOR'
   AND P.CO_CODE ='NS'--LIKE &CO_CODE
   AND P.WHSE_CODE =A.C_IN_ERPRNO--p_rcv_no--SUBSTR(&RCV_NO,1,INSTR(&RCV_NO,'-',1,1)-1)--LIKE &WHSE_CODE
   AND p.item_id =A.C_IN_ProductId--P_ITEM_ID --LIKE  &p_item_id
	  AND RSH.RECEIPT_NUM =p_rcv_no--SUBSTR(&RCV_NO,INSTR(&RCV_NO,'-',1,1)+1,LENGTH(&RCV_NO)-INSTR(&RCV_NO,'-',1,1))--LIKE &RCV_NUMBER
   --AND PV.VENDOR_NAME =\*'波士胶芬得利(中国)粘合剂有限公司'--*\'波士胶芬得利（中国）粘合剂有限公司'
  
   )*\
		;

    
    CR_PO_RET PO_RET%ROWTYPE;
		L_RET_NUM NUMBER;
  BEGIN
    
       
    L_TRANS:='UPDATE WMS IN LINE PO RETURN QTY;';
		
	FOR CR_PO_RET in PO_RET
      LOOP
	BEGIN
	L_RET_NUM:=NVL(GET_RETURN_QTY(CR_PO_RET.C_IN_ProductId,CR_PO_RET.C_IN_ERPRNO),CR_PO_RET.C_IN_BackedNum);
	
    UPDATE CENTER_IN_NOTIFYDETAIL A
		SET A.C_IN_BackedNum=L_RET_NUM
		WHERE A.C_IN_ERPRNO IS NOT NULL
		AND A.C_IN_Order=CR_PO_RET.C_IN_Order
		;
    EXCEPTION
      WHEN OTHERS THEN
        V_ERROR_MSG:='upadte 不成功！ ';
        RAISE ERR_OTHERS;
    END;
		
		END LOOP;

    V_RETURN_STATUS := 'S';
    V_ERROR_MSG:=V_ERROR_MSG||' UPDATE WMS IN LINE PO RETURN QTY 正常完成！';
      
      COMMIT;
   
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
     
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
      
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
   
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
     
    
    when others THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
  END;*/
	
	

/*###############################################################
  # NAME
  #  UPDATE_WMS_IN_RET_QTY
  # SYNOPSIS
  #  proc UPDATE_WMS_IN_RET_QTY
  # DESCRIPTION
  #  1、周期 定时  UPDATE  UPDATE_WMS_IN_RET_QTY.C_IN_BackedNum 退货数量
  #  2、每小时upadte一次
  ###############################################################*/  
procedure UPDATE_WMS_IN_RET_QTY(V_RETURN_STATUS OUT VARCHAR2,
                    V_ERROR_MSG     OUT VARCHAR2)
   AS
   
   
    /*ERR_PARAMETER EXCEPTION;
    ERR_NO_DATA EXCEPTION;
    ERR_OTHERS EXCEPTION;*/
    L_TRANS                    VARCHAR2(1000);
    L_MSG     VARCHAR2(4000) := ' ';
    
    --V_RETURN_STATUS VARCHAR2(10):='S';
    --V_ERROR_MSG     VARCHAR2(4000);
    
    L_RETURN_STATUS_U VARCHAR2(10);
    
   
    L_REMARK       VARCHAR2(100):='UPDATE WMS RET QTY';
    
    L_RETURN_STATUS VARCHAR2(10):='S';
    L_ERROR_MSG     VARCHAR2(4000);
    
    cursor PO_RET IS
    SELECT A.C_IN_Order,C_IN_BackedNum,C_IN_ProductId,C_IN_ERPRNO FROM CENTER_IN_NOTIFYDETAIL A,CENTER_IN_NOTIFY H
    WHERE A.C_IN_ID=H.C_IN_ID
    AND H.C_IN_Type=9
    AND A.C_IN_ERPRNO IS NOT NULL
    AND A.C_IN_BackedNum <> NVL(GET_RETURN_QTY(A.C_IN_ProductId,A.C_IN_ERPRNO),C_IN_BackedNum)
  
    ;

    
    CR_PO_RET PO_RET%ROWTYPE;
    L_RET_NUM NUMBER;
  BEGIN
    
       
    L_TRANS:='UPDATE WMS IN LINE PO RETURN QTY;';
    
  FOR CR_PO_RET in PO_RET
      LOOP
  BEGIN
  L_RET_NUM:=NVL(GET_RETURN_QTY(CR_PO_RET.C_IN_ProductId,CR_PO_RET.C_IN_ERPRNO),CR_PO_RET.C_IN_BackedNum);
  
    UPDATE CENTER_IN_NOTIFYDETAIL A
    SET A.C_IN_BackedNum=L_RET_NUM--NVL(GET_RETURN_QTY(A.C_IN_ProductId,A.C_IN_ERPRNO),A.C_IN_BackedNum)
    WHERE A.C_IN_ERPRNO IS NOT NULL
    AND A.C_IN_BackedNum <> L_RET_NUM--NVL(GET_RETURN_QTY(A.C_IN_ProductId,A.C_IN_ERPRNO),A.C_IN_BackedNum)
		AND A.C_IN_ID 
		IN (
		SELECT H.C_IN_ID FROM CENTER_IN_NOTIFY H
		WHERE H.C_IN_Type =9
		)
		AND a.C_IN_Order=CR_PO_RET.C_IN_Order
    ;
    EXCEPTION
      WHEN OTHERS THEN
        V_ERROR_MSG:='upadte 不成功！ ';
        RAISE ERR_OTHERS;
    END;
    
    END LOOP;

    V_RETURN_STATUS :='S';
    V_ERROR_MSG:=V_ERROR_MSG||' UPDATE WMS IN LINE PO RETURN QTY 正常完成！';
      
      COMMIT;
   
  EXCEPTION
    WHEN ERR_PARAMETER THEN
      V_RETURN_STATUS := 'U';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
     
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
      
    WHEN ERR_NO_DATA THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
      
   
    WHEN ERR_OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
     
    
    when others THEN
      V_RETURN_STATUS := 'E';
      V_ERROR_MSG:=V_ERROR_MSG||';'||L_TRANS||' 异常 '|| SQLERRM;
      MSG_OUTPUT('================exception========================');
      MSG_OUTPUT('V_RETURN_STATUS: '||V_RETURN_STATUS);
      MSG_OUTPUT('V_ERROR_MSG: '||V_ERROR_MSG);
    
  END;

end CUX_DEVELOP_NS_PO_PKG;
/
