--item ������Ϣ
--OPM ITEM
SELECT --T.ITEM_ID,
       T.ITEM_NO ���ϱ���,
       T.ITEM_DESC1 ��������,
       T.ITEM_UM ��һ��λ,
       T.ITEM_UM2 �ڶ���λ,
       T.ALLOC_CLASS      ������༯,--���������Ϊ��AUTOFIFO�������������Զ�������������
       T.GL_CLASS         GL���༯,
			 GL.STRUCTURE_NAME GL_FL,
       GL.CATEGORY_CONCAT_SEGS ���Ϸ������,
       GL.DESCRIPTION ���Ϸ�������,
			 
       T.INV_CLASS        ������Ϸ��༯,
			 INV.STRUCTURE_NAME INV_FL,
       INV.CATEGORY_CONCAT_SEGS ���Ϸ������,
       INV.DESCRIPTION ���Ϸ�������,
			 
       T.ITEMCOST_CLASS   �ɱ����༯,
			 CB.STRUCTURE_NAME CB_FL,
       CB.CATEGORY_CONCAT_SEGS ���Ϸ������,
       CB.DESCRIPTION ���Ϸ�������,
			 
       t.attribute1  Ԥ����Ŀ,
       decode(T.LOT_CTL,0,'��','��') ���ο���,
       DECODE(T.SUBLOT_CTL,0,'��','��') �����ο���
       ,DECODE(T.LOCT_CTL,0,'��','��') �ص����
       /*,
       T.GL_CATEGORY_ID,
       T.INV_CATEGORY_ID,
       T.COST_CATEGORY_ID,
       T.CREATION_DATE,
       T.DELETE_MARK,
       T.WHSE_ITEM_ID,
       T.INACTIVE_IND     ��Ч���,
       T.LAST_UPDATE_DATE,
       T.LAST_UPDATED_BY,
       T.**/
  FROM IC_ITEM_MST_B T,MTL_CATEGORIES_V GL
	,MTL_CATEGORIES_V INV
	,MTL_CATEGORIES_V CB
 WHERE
/*AND T.INACTIVE_IND=0--��Ч���
AND T.EXPERIMENTAL_IND ==0--"ʵ��"
AND T.DELETE_MARK =1--���Ϊɾ��
AND T.DUALUM_IND=0--0:��˫UOM;1:�̶���2��Ĭ��ֵ��3����Ĭ�Ͽ���
AND T.NONINV_IND=0--0:�����ƣ�1���ǿ�����
AND T.LOCT_CTL=0--0:�ǵص���ƣ�1���ص����
AND T.LOT_CTL=0--0:�����ο��ƣ�1�����ο���
AND T.LOT_INDIVISIBLE=0--0:�ɷָ1�����ɷָ�
AND T.SUBLOT_CTL=0--0���������ο��ƣ�1�������ο���
T.ATTRIBUTE1 --���������
T.ATTRIBUTE2 --�����Ŀ
*/
T.GL_CATEGORY_ID=GL.CATEGORY_ID
AND  NVL(GL.DISABLE_DATE,SYSDATE+1) >= SYSDATE 

AND T.INV_CATEGORY_ID=INV.CATEGORY_ID
AND  NVL(INV.DISABLE_DATE,SYSDATE+1) >= SYSDATE

AND T.COST_CATEGORY_ID=CB.CATEGORY_ID
AND  NVL(CB.DISABLE_DATE,SYSDATE+1) >= SYSDATE

AND 
 T.ITEM_NO LIKE &ITEM_NO --'01-11-99'ITEM_DESC
 AND T.ITEM_DESC1 LIKE &ITEM_DESC
 AND T.ITEM_ID LIKE &ITEM_ID
AND T.ITEM_NO NOT LIKE '09%'
and T.INACTIVE_IND=0--��Ч���
--AND T.EXPERIMENTAL_IND ==0--"ʵ��"
AND T.DELETE_MARK =0--���Ϊɾ��
/*
AND (T.ITEM_NO LIKE '08-31%'
OR T.ITEM_NO LIKE '08-32%'
OR T.ITEM_NO LIKE '08-39%'
)*/
AND INV.CATEGORY_CONCAT_SEGS  LIKE &INV_CLASS
AND CB.CATEGORY_CONCAT_SEGS  LIKE &CB_CLASS
AND GL.CATEGORY_CONCAT_SEGS  LIKE &GL_CLASS
;
