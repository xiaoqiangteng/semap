clear all;
close all;
str = fileread( 'feature.xml' );
v = xml_parse( str );
A_row=str2num(v.A.rows);A_witdh=str2num(v.A.cols);A_data=str2num(v.A.data);
B_row=str2num(v.B.rows);B_witdh=str2num(v.B.cols);B_data=str2num(v.B.data);
C_row=str2num(v.C.rows);C_witdh=str2num(v.C.cols);C_data=str2num(v.C.data);
D_row=str2num(v.D.rows);D_witdh=str2num(v.D.cols);D_data=str2num(v.D.data);
E_row=str2num(v.E.rows);E_witdh=str2num(v.E.cols);E_data=str2num(v.E.data);





