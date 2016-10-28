# ExternalIO-RPG
<p>

The purpose of this project is R&D into patterns for RPG record-level access (RLA) to reduce the impact of DB changes.  Ideally a table change would only require a re-compile of the I/O service program, and associated programs would work without a re-compile.  The code was developed on IBM i 7.1 with the latest Technology Refresh (TR) using RDi 9.5.
<p>

<b>Setup:</b>
<br>
<ul>
<li>Create 'src/externalIO/' in your IFS home directory and copy the RPG directory into it.</li>
<li>Create a QSRVSRC source file in your current library and copy the two files under Binding into it as source members.</li>
<li>Use your favorite SQL client and run DB/createItems to create the PF in your current library.</li>
</ul>
<p>

<b>Usage:</b>
<br>
<ul>
<li>Compile itemsio1.rpgle and itemsioTC.rpgle using the commands at the top of the source in order to create them in your current library.</li>
<li>Call ITEMSIOTC to load sample rows into ITEMS table.</li>
<li>Use a SQL client to run DB/alterItems in order to modify the table layout to increase the size of three columns.</li>
<li>Compile itemsio2.rpgle using the commands at the top of the source.  This will recreate the ITEMSIO service program using the new table layout.</li>
<li>Call ITEMSIOTC again, without a re-compile.</li>
</ul>