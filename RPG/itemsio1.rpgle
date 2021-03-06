**free
      /if not defined(MAIN)
//        CRTRPGMOD MODULE(QTEMP/ITEMSIO) SRCSTMF('src/externalIO/RPG/itemsio1.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE)
//        CRTSRVPGM SRVPGM(ITEMSIO) MODULE(QTEMP/ITEMSIO) ARGOPT(*YES) EXPORT(*SRCFILE) SRCFILE(QSRVSRC) SRCMBR(ITEMSIO1)
       Ctl-opt
         Debug(*Yes) Option(*SrcStmt: *NoDebugIO :*NoUnref) Optimize(*Basic)
         NoMain ExtBinInt(*Yes)
       ;


      Dcl-f ITEMS disk usage(*input :*update :*output) keyed usrOpn rename(ITEMS :ITEMS_REC) ;

      /endif

       //----------------------------------------------------------------------
       //  exported prototypes
       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Prototype for procedure: OpenITEMS
       // Purpose:        Open table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-pr OpenITEMS ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: CloseITEMS
       // Purpose:        Close table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-pr CloseITEMS ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: ClearITEMS
       // Purpose:        Clear all variables for table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-pr ClearITEMS ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: ReadITEMS
       // Purpose:        Read next row from table ITEMS
       // Returns:        EOF
       // --------------------------------------------------
       Dcl-pr ReadITEMS ind ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: SetllITEMS
       // Purpose:        Position row pointer for table ITEMS
       // Returns:        null
       // Parameter:      partNo => Part number
       // Parameter:      vendorNo => Vendor number
       // --------------------------------------------------
       Dcl-pr SetllITEMS ;
         partNo int(10) const ;
         vendorNo int(10) const options(*noPass) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: ReadeITEMS
       // Purpose:        Read next matching key row from table ITEMS
       // Returns:        EOF
       // Parameter:      partNo => Part number
       // Parameter:      vendorNo => Vendor number
       // --------------------------------------------------
       Dcl-pr ReadeITEMS ind ;
         partNo int(10) const ;
         vendorNo int(10) const options(*noPass) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: UpdateITEMS
       // Purpose:        Update existing row in table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-pr UpdateITEMS ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: WriteITEMS
       // Purpose:        Create new row in table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-pr WriteITEMS ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: GetItemsPartNo
       // Purpose:        Retrieve partNo for current row
       // Returns:        Part number
       // --------------------------------------------------
       Dcl-pr GetItemsPartNo like(gItemsIO.partNo) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: SetItemsPartNo
       // Purpose:        Set partNo for current row
       // Returns:        null
       // Parameter:      partNo => Part number
       // --------------------------------------------------
       Dcl-pr SetItemsPartNo ;
         partNo like(gItemsIO.partNo) const ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: GetItemsVendorNo
       // Purpose:        Retrieve vendorNo for current row
       // Returns:        Vendor number
       // --------------------------------------------------
       Dcl-pr GetItemsVendorNo like(gItemsIO.vendorNo) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: SetItemsVendorNo
       // Purpose:        Set vendorNo for current row
       // Returns:        null
       // Parameter:      vendorNo => Vendor number
       // --------------------------------------------------
       Dcl-pr SetItemsVendorNo ;
         vendorNo like(gItemsIO.vendorNo) const ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: GetItemsPartDescr
       // Purpose:        Retrieve partDescr for current row
       // Returns:        Part description
       // --------------------------------------------------
       Dcl-pr GetItemsPartDescr like(gItemsIO.partDescr) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: SetItemsPartDescr
       // Purpose:        Set partDescr for current row
       // Returns:        null
       // Parameter:      partDescr => Part description
       // --------------------------------------------------
       Dcl-pr SetItemsPartDescr ;
         partDesc like(gItemsIO.partDescr) const ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: GetItemsWholesale
       // Purpose:        Retrieve wholesale for current row
       // Returns:        Wholesale cost
       // --------------------------------------------------
       Dcl-pr GetItemsWholesale like(gItemsIO.wholesale) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: SetItemsWholesale
       // Purpose:        Set wholesale for current row
       // Returns:        null
       // Parameter:      wholesale => Wholesale cost
       // --------------------------------------------------
       Dcl-pr SetItemsWholesale ;
         wholesale like(gItemsIO.wholesale) const ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: GetItemsRetail
       // Purpose:        Retrieve retail for current row
       // Returns:        Retail price
       // --------------------------------------------------
       Dcl-pr GetItemsRetail like(gItemsIO.retail) ;
       End-pr ;

       // --------------------------------------------------
       // Prototype for procedure: SetItemsRetail
       // Purpose:        Set retail for current row
       // Returns:        null
       // Parameter:      retail => Retail price
       // --------------------------------------------------
       Dcl-pr SetItemsRetail ;
         retail like(gItemsIO.retail) const ;
       End-pr ;

       //----------------------------------------------------------------------
       //  exported data structures
       //----------------------------------------------------------------------
       Dcl-ds gItemsIO extName('ITEMS') qualified template inz ;
       End-ds;

      /if defined(MAIN)
      /EOF
      /endif


       //----------------------------------------------------------------------
       //  global data structures
       //----------------------------------------------------------------------
       Dcl-ds ItemsDs likeRec(ITEMS_REC) inz;

       //----------------------------------------------------------------------
       //  exported procedures
       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: OpenITEMS
       // Purpose:        Open table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-proc OpenITEMS export ;

         //--------------------------------------------------------------------

       If not %open(ITEMS);
         Open ITEMS;
       Endif;

       Return ;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: CloseITEMS
       // Purpose:        Close table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-proc CloseITEMS export ;

         //--------------------------------------------------------------------

       Close(e) ITEMS;

       Return ;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: ClearITEMS
       // Purpose:        Clear all variables for able ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-proc ClearITEMS export ;

         //--------------------------------------------------------------------

       Reset ItemsDs;

       Return ;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: ReadITEMS
       // Purpose:        Read next row from table ITEMS
       // Returns:        EOF
       // --------------------------------------------------
       Dcl-proc ReadITEMS export ;
         Dcl-pi *n ind ;
         End-pi;

         //--------------------------------------------------------------------

       Read ITEMS ItemsDs;

       Return %eof(ITEMS);
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: SetllITEMS
       // Purpose:        Position row pointer for table ITEMS
       // Returns:        null
       // Parameter:      partNo => Part number
       // Parameter:      vendorNo => Vendor number
       // --------------------------------------------------
       Dcl-proc SetllITEMS export ;
         Dcl-pi *n ;
           partNo like(ItemsDs.partNo) const ;
           vendorNo like(ItemsDs.vendorNo) const options(*noPass) ;
         End-pi;

         //--------------------------------------------------------------------

       If %parms() >= %parmNum(vendorNo);
         Setll (partNo :vendorNo) ITEMS;
       Else;
         Setll (partNo) ITEMS;
       Endif;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: ReadeITEMS
       // Purpose:        Read next matching key row from table ITEMS
       // Returns:        EOF
       // Parameter:      partNo => Part number
       // Parameter:      vendorNo => Vendor number
       // --------------------------------------------------
       Dcl-proc ReadeITEMS export ;
         Dcl-pi *n ind ;
           partNo like(ItemsDs.partNo) const ;
           vendorNo like(ItemsDs.vendorNo) const options(*noPass) ;
         End-pi;

         //--------------------------------------------------------------------

       If %parms() >= %parmNum(vendorNo);
         Reade (partNo :vendorNo) ITEMS ItemsDs;
       Else;
         Reade (partNo) ITEMS ItemsDs;
       Endif;

       Return %eof(ITEMS);
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: UpdateITEMS
       // Purpose:        Update existing row in table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-proc UpdateITEMS export ;

         //--------------------------------------------------------------------

       Update ITEMS_REC ItemsDs;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure name: WriteITEMS
       // Purpose:        Create new row in table ITEMS
       // Returns:        null
       // --------------------------------------------------
       Dcl-proc WriteITEMS export ;

         //--------------------------------------------------------------------

       Write ITEMS_REC ItemsDs;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      GetItemsPartNo
       // Purpose:        Retrieve partNo for current row
       // Returns:        Part number
       // --------------------------------------------------
       Dcl-proc GetItemsPartNo export ;
         Dcl-pi *n like(gItemsIO.partNo) ;
         End-pi;

       Return ItemsDs.partNo;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      SetItemsPartNo
       // Purpose:        Set partNo for current row
       // Returns:        null
       // Parameter:      partNo => Part number
       // --------------------------------------------------
       Dcl-proc SetItemsPartNo export ;
         Dcl-pi *n ;
           partNo like(gItemsIO.partNo) const ;
         End-pi ;

       ItemsDs.partNo = partNo;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      GetItemsVendorNo
       // Purpose:        Retrieve vendorNo for current row
       // Returns:        Vendor number
       // --------------------------------------------------
       Dcl-proc GetItemsVendorNo export ;
         Dcl-pi *n like(gItemsIO.vendorNo) ;
         End-pi;

       Return ItemsDs.vendorNo;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      SetItemsVendorNo
       // Purpose:        Set vendorNo for current row
       // Returns:        null
       // Parameter:      vendorNo => Vendor number
       // --------------------------------------------------
       Dcl-proc SetItemsVendorNo export ;
         Dcl-pi *n ;
           vendorNo like(gItemsIO.vendorNo) const ;
         End-pi;

       ItemsDs.vendorNo = vendorNo;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      GetItemsPartDescr
       // Purpose:        Retrieve partDescr for current row
       // Returns:        Part description
       // --------------------------------------------------
       Dcl-proc GetItemsPartDescr export ;
         Dcl-pi *n like(gItemsIO.partDescr) ;
         End-pi;

       Return ItemsDs.partDescr;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      SetItemsPartDescr
       // Purpose:        Set partDescr for current row
       // Returns:        null
       // Parameter:      partDescr => Part description
       // --------------------------------------------------
       Dcl-proc SetItemsPartDescr export ;
         Dcl-pi *n ;
           partDescr like(gItemsIO.partDescr) const ;
         End-pi ;

       ItemsDs.partDescr = partDescr;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      GetItemsWholesale
       // Purpose:        Retrieve wholesale for current row
       // Returns:        Wholesale cost
       // --------------------------------------------------
       Dcl-proc GetItemsWholesale export ;
         Dcl-pi *n like(gItemsIO.wholesale) ;
         End-pi;

       Return ItemsDs.wholesale;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      SetItemsWholesale
       // Purpose:        Set wholesale for current row
       // Returns:        null
       // Parameter:      wholesale => Wholesale cost
       // --------------------------------------------------
       Dcl-proc SetItemsWholesale export ;
         Dcl-pi *n ;
           wholesale like(gItemsIO.wholesale) const ;
         End-pi ;

       ItemsDs.wholesale = wholesale;

       Return;
       End-proc ;

       //----------------------------------------------------------------------

       // --------------------------------------------------
       // Procedure:      GetItemsRetail
       // Purpose:        Retrieve retail for current row
       // Returns:        Retail price
       // --------------------------------------------------
       Dcl-proc GetItemsRetail export ;
         Dcl-pi *n like(gItemsIO.retail) ;
         End-pi;

       Return ItemsDs.retail;
       End-proc ;

       // --------------------------------------------------
       // Procedure:      SetItemsRetail
       // Purpose:        Set retail for current row
       // Returns:        null
       // Parameter:      retail => Retail price
       // --------------------------------------------------
       Dcl-proc SetItemsRetail export ;
         Dcl-pi *n ;
           retail like(gItemsIO.retail) const ;
         End-pi ;

       ItemsDs.retail = retail;

       Return;
       End-proc ;
