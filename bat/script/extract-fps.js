var objArgs   = WScript.Arguments;
var InFile    = objArgs(0);
var OutFile   = objArgs(1);

var fs       = new ActiveXObject( "Scripting.FileSystemObject" );
var inf      = fs.OpenTextFile( InFile , 1 , true );
var FFmpeg   = inf.ReadAll();
// 参考:http://blog-tmtsts.rhcloud.com/456
var FPS    = FFmpeg.match( /(\d+\.\d+|\d+)(\s*fps)/g );
inf.Close();
var outf     = fs.OpenTextFile( OutFile , 2 , true );
outf.WriteLine( FPS[ FPS.length - 1 ].slice( 0 , FPS[ FPS.length - 1 ].length - 4 ) );
outf.Close();