var objArgs = WScript.Arguments;

//http://dqn.sakusakutto.jp/2009/02/imagemagick_jscriptwsh.html

var img = new ActiveXObject( "ImageMagickObject.MagickImage.1" );
var file_in        = objArgs(0);

var img_width      = img.Identify( "-format", "%w",  file_in );
var img_height     = img.Identify( "-format", "%h",  file_in );

WSH.echo( img_width );
WSH.echo( img_height );

var target_width   = objArgs(1);
var target_height  = objArgs(2);

WSH.echo( target_width );
WSH.echo( target_height );

var multset_file   = objArgs(3);

var outwidth       = objArgs(4);
var outheight      = objArgs(5);

WSH.echo( multset_file );

var mag_candid_w   = target_width  / img_width;
var mag_candid_h   = target_height / img_height;

WSH.echo( mag_candid_w );
WSH.echo( mag_candid_h );

if ( mag_candid_w <= 1 && mag_candid_h <= 1 && mag_candid_w <= mag_candid_h ) {
 var Magnific    = "0"; //height
} else if ( mag_candid_w <= 1 && mag_candid_h <= 1 && mag_candid_w > mag_candid_h ) {
 var Magnific    = "1"; //width
} else if ( target_width == 0 ){
 var Magnific    = mag_candid_h;
} else if ( target_height == 0 ){
 var Magnific    = mag_candid_w;
} else if ( mag_candid_w <= mag_candid_h ){
 var Magnific    = mag_candid_h;
} else if ( mag_candid_w > mag_candid_h ){
 var Magnific    = mag_candid_w;
} else {
 WSH.echo( "error!" );
}
WSH.echo( "Magnific:" + Magnific );

if ( Magnific <= 1 ) {
 var OutMagnific = Magnific;
} else {
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
var widtf = fs.OpenTextFile( outwidth , 2 , true );
widtf.WriteLine( img_width );
widtf.Close();
var heigf = fs.OpenTextFile( outheight , 2 , true );
heigf.WriteLine( img_height );
heigf.Close();