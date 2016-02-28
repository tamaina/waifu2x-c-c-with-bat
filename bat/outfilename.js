var objArgs = WScript.Arguments;

var outfolder    = objArgs(0); 
//C:\--\gazo\hoge\waifued
var foldername   = objArgs(1); //waifued
var thedp        = objArgs(2); 
//A   C:\--\gazo\hoge\[image.jpg]
//B   C:\--\nyan\koka\[waiiz.png]
var OutFile      = objArgs(3); //fset.txt
var upperfolder  = objArgs(4); 
//A   C:\--\nyan\ (ƒIƒvƒVƒ‡ƒ“)

WSH.echo( outfolder );
WSH.echo( foldername );
WSH.echo( thedp );
WSH.echo( OutFile );
WSH.echo( upperfolder );

if ( upperfolder == "false" ){

var hogeb        = thedp.lastIndexOf( "\\" );
//10
var hogec        = thedp.slice( hogeb );
//(C:\--\nyan)\koka\[waiiz.png]
var thisfolder   = outfolder + hogec;
} else {
var hogea        = upperfolder.lastIndexOf( "\\" );
var hogeaa       = upperfolder.slice( 0 , hogea );
WSH.echo( hogeaa );
var hogeb        = hogeaa.length
//5
var hogec        = thedp.slice( hogeb );
//(C:\--)\nyan\koka\[waiiz.png]
var thisfolder   = outfolder + hogec;
}
WSH.echo( hogeb );
WSH.echo( thisfolder );
WSH.echo( "Out:" + OutFile );
var fs = new ActiveXObject( "Scripting.FileSystemObject" );
var f = fs.OpenTextFile( OutFile , 2 , true );
f.WriteLine( thisfolder );
f.Close();