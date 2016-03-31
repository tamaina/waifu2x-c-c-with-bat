var objArgs   = WScript.Arguments;
var InFile    = objArgs(0);
var OutFile   = objArgs(1);

var fs       = new ActiveXObject( "Scripting.FileSystemObject" );
var inf      = fs.OpenTextFile( InFile , 1 , true );
var identify = inf.ReadAll();
// 参考:http://blog-tmtsts.rhcloud.com/456
var transp   = identify.match( /(  Transparent color: srgba\()(.+)(\))/ );
inf.Close();
var outf     = fs.OpenTextFile( OutFile , 2 , true )
outf.WriteLine( transp[2] );
outf.Close();