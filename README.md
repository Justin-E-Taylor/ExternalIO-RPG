# ExternalIO-RPG

The purpose of this project is R&D into patterns for RPG record-level access (RLA) to reduce the impact of DB changes.  Ideally a table change would only require a re-compile of the I/O service program, and associated programs would work without a re-compile.  The code was developed on IBM i 7.1 with the latest Technology Refresh (TR) using RDi 9.5.


Setup:
Create 'src/externalIO/' in your IFS home directory and copy the RPG directory into it.
Create a QSRVSRC source file in your current library and copy the two files under Binding into it.
Use your favorite SQL client and run DB/createItems to create the PF in your current library.


Usage:
Compile itemsio1.rpgle and itemsioTC.rpgle using the commands at the top of the source in order to compile them to your current library.
Call ITEMSIOTC to load sample rows into ITEMS table.
Use a SQL client to run DB/alterItems in order to modify the table layout to increase the size of three columns.
Compile itemsio2.rpgle using the commands at the top of the source.  This will recreate the ITEMSIO service program using the new table layout.
Call ITEMSIOTC again, without a re-compile.
