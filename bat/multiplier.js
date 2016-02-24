var objArgs = WScript.Arguments;

//http://dqn.sakusakutto.jp/2009/02/imagemagick_jscriptwsh.html

var img = new ActiveXObject( "ImageMagickObject.MagickImage.1" );
var file_in        = objArgs(0);

var img_width      = img.Identify( "-format", "%w",  file_in );
var img_height     = img.Identify( "-format", "%h",  file_in );

WSH.echo( img_width )
WSH.echo( img_height )

var target_width   = objArgs(1);
var target_height  = objArgs(2);

WSH.echo( target_width )
WSH.echo( target_height )

var multset_file   = objArgs(3);

var accuracy       = 10 //objArgs(4);

WSH.echo( multset_file )

var mag_candid_w   = target_width  / img_width;
var mag_candid_h   = target_height / img_height;

WSH.echo( mag_candid_w );
WSH.echo( mag_candid_h );

if ( mag_candid_w <= 1 && mag_candid_h <= 1 && mag_candid_w < mag_candid_h ) {
 var OutMagnific    = "Height";
} else if ( mag_candid_w <= 1 && mag_candid_h <= 1 && mag_candid_w > mag_candid_h ) {
 var OutMagnific    = "Width";
} else if ( target_width == 0 ){
 var Magnific    = mag_candid_h;
} else if ( target_height == 0 ){
 var Magnific    = mag_candid_w;
} else if ( mag_candid_w < mag_candid_h ){
 var Magnific    = mag_candid_h;
} else if ( mag_candid_w > mag_candid_h ){
 var Magnific    = mag_candid_w;
} else {
 WSH.echo( "error!" );
}
WSH.echo( OutMagnific );
WSH.echo( Magnific );

if ( OutMagnific == "Height" ){
WSH.echo( OutMagnific );
} else if ( OutMagnific == "Width" ){
WSH.echo( OutMagnific );
} else {
 var OutMagnific       = Math.ceil( Magnific * accuracy ) / accuracy;
 var echoval           = "Ž©“®”{—¦ŒvŽZŒ‹‰Ê:" + OutMagnific + "”{";
 WSH.echo( echoval );
}

var fs = new ActiveXObject( "Scripting.FileSystemObject" );
var f = fs.OpenTextFile( multset_file , 2 , true );
f.WriteLine( OutMagnific );
f.Close();