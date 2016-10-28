**free
      /define MAIN
//        CRTRPGMOD MODULE(QTEMP/ITEMSIOTC) SRCSTMF('src/externalIO/RPG/itemsioTC.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE)
//        CRTPGM PGM(ITEMSIOTC) MODULE(QTEMP/ITEMSIOTC) ARGOPT(*YES) BNDSRVPGM(ITEMSIO) ACTGRP(ITEMSIOTC)
       Ctl-opt
         Debug(*Yes) Option(*SrcStmt: *NoDebugIO :*NoUnref) Optimize(*Basic)
         ExtBinInt(*Yes)
         Main(main)
       ;

      //-----------------------------------------------------------------------
      //  external prototypes
      //-----------------------------------------------------------------------
      /include src/externalIO/RPG/itemsio1.rpgle

      //-----------------------------------------------------------------------
      //  internal prototypes
      //-----------------------------------------------------------------------

       // --------------------------------------------------
       // Prototype for procedure: main
       // Purpose:        Main method
       // Returns:        null
       // --------------------------------------------------
       Dcl-pr main extPgm('ITEMSIOTC') ;
       End-pr ;

      //-----------------------------------------------------------------------
      //  procedures
      //-----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: main
       // Purpose:        Main method
       // Returns:        null
       // --------------------------------------------------
       Dcl-proc main ;

         //--------------------------------------------------------------------
         //  records
         //--------------------------------------------------------------------
         Dcl-ds lItemsDs likeDs(gItemsIO) inz ;

         //--------------------------------------------------------------------
         //  stand-alone fields
         //--------------------------------------------------------------------
         Dcl-s error ind ;

         //--------------------------------------------------------------------

       Monitor;
         OpenITEMS();


         // Write sample rows.
         ClearITEMS();
         SetllITEMS(1);
         If ReadeITEMS(1) = *on;
           SetItemsPartNo(1);
           SetItemsVendorNo(1);
           SetItemsPartDescr('Widget 1');
           SetItemsWholesale(1.75);
           SetItemsRetail(9.99);
           WriteITEMS();
         Else;
           SetItemsPartDescr('Widget 1');
           SetItemsWholesale(1.75);
           SetItemsRetail(9.99);
           UpdateITEMS();
         Endif;
         If ReadeITEMS(1 :2) = *on;
           SetItemsPartNo(1);
           SetItemsVendorNo(2);
           SetItemsPartDescr('Widget 1');
           SetItemsWholesale(2.23);
           SetItemsRetail(9.99);
           WriteITEMS();
         Else;
           SetItemsPartDescr('Widget 1');
           SetItemsWholesale(2.23);
           SetItemsRetail(9.99);
           UpdateITEMS();
         Endif;


         // Full read, keyed order.
         SetllITEMS(0);
         Dow ReadITEMS() = *off;
           lItemsDs.partNo = GetItemsPartNo();
           lItemsDs.vendorNo = GetItemsVendorNo();
           lItemsDs.partDescr = GetItemsPartDescr();
           lItemsDs.wholesale = GetItemsWholesale();
           lItemsDs.retail = GetItemsRetail();
         Enddo;


         //  Random access, single row.
         SetllITEMS(1 :2);
         If ReadeITEMS(1 :2) = *off;
           If GetItemsPartNo() <> 1
               or GetItemsVendorNo() <> 2
               or GetItemsPartDescr() <> 'Widget 1'
               or GetItemsWholesale() <> 2.23
               or GetItemsRetail() <> 9.99
               ;
             error = *on;
           Else;
             SetItemsRetail(10.99);
             UpdateITEMS();
           Endif;
         Endif;
         SetllITEMS(1);
         If ReadeITEMS(1) = *off;
          If GetItemsPartNo() <> 1
               or GetItemsVendorNo() <> 1
               or GetItemsPartDescr() <> 'Widget 1'
               or GetItemsWholesale() <> 1.75
               or GetItemsRetail() <> 9.99
               ;
             error = *on;
           Else;
             SetItemsRetail(10.99);
             UpdateITEMS();
           Endif;
         Endif;


       On-Error;
         error = *on;
       Endmon;

       CloseITEMS();

       Dsply ('Error condition:' + error);

       Return ;
       End-proc ;

