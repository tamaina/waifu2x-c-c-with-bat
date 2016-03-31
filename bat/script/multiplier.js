var objArgs = WScript.Arguments;
var cuifrontend = false;
//http://dqn.sakusakutto.jp/2009/02/imagemagick_jscriptwsh.html

var img_width      = objArgs(5);
var img_height     = objArgs(4);

//WSH.echo( img_width );
//WSH.echo( img_height );

var target_width   = objArgs(1);
var target_height  = objArgs(2);

//WSH.echo( target_width );
//WSH.echo( target_height );

var multset_file   = objArgs(3);

//WSH.echo( multset_file );

var mag_candid_w   = target_width  / img_width;
var mag_candid_h   = target_height / img_height;

WSH.echo( mag_candid_w );
WSH.echo( mag_candid_h );

if ( objArgs(6) == "true" ) {

 if ( mag_candid_w <= 1 && mag_candid_h <= 1 && mag_candid_w <= mag_candid_h ) {
 var Magnific    = "0";
 } else if ( mag_candid_w <= 1 && mag_candid_h <= 1 && mag_candid_w > mag_candid_h ) {
 var Magnific    = "1";
 } else if ( target_width == 0 ) {
 var Magnific    = mag_candid_h;
 } else if ( target_height == 0 ) {
 var Magnific    = mag_candid_w;
 } else if ( mag_candid_w <= mag_candid_h ) {
 var Magnific    = mag_candid_h;
 } else if ( mag_candid_w > mag_candid_h ) {
 var Magnific    = mag_candid_w;
 } else {
 WSH.echo( "error!" );
 }


 if ( Magnific <= 1 ) {
 var OutMagnific = Magnific;
 } else {
 WSH.echo( "M" + Magnific );
 var OutMagnific       = 0;
 var i = 0;
 var POW = 0;
 while ( Magnific > POW ) {
  var POW = Math.pow( 2 , i );
  i++;
  WSH.echo( POW );
 }
 i--;
 var OutMagnific       = Math.pow( 2 , i );
}

} else {
WSH.echo( "Mgn" + Magnific );
var Magnific       = objArgs(7);
var OutMagnific       = 0;
var i = 0;
var POW = 0;
while ( Magnific > POW ) {
 var POW = Math.pow( 2 , i );
 i++;
WSH.echo( POW );
}
i--;
var OutMagnific       = Math.pow( 2 , i );

}
WSH.echo( "Out:" + OutMagnific );
var fs = new ActiveXObject( "Scripting.FileSystemObject" );
var multf = fs.OpenTextFile( multset_file , 2 , true );
multf.WriteLine( OutMagnific );
multf.Close();
