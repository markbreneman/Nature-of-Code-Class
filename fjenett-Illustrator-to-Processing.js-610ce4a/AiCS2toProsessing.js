/*
	From Illustrator to Processing.
	
	Converts an illustration from inside Illustrator CS2 / CS3 into Processing drawing commands
	which are then saved to a ".pde" file (sketch) for Processing.
	
	Florian Jenett, mail@florianjenett.de
	
	Processing:
	http://processing.org/
	
	Javascript reference for Illustrator CS2 can be found here:
	http://www.adobe.com/devnet/illustrator/sdk/
	
	--------------------------------------------------------------------------------------
	
	Version: 004, fjenett 20080503
	
	--------------------------------------------------------------------------------------
	
	Changes:
		fjenett 20080504: added stroke weight, color and opacity
		fjenett 20080503: fixed naming of generated functions. if item is not named use parents 
						  (layer / group) name instead. umlauts and ß are translated to ascii.
		fjenett 20080501: fixed bounding box issues for groups, now hidden items will be included.
						  this allows to position elements inside a hidden area
		fjenett 20080406: fixed file name problem where replace() was only looking for ".ai"
	
*/


/* ---------------------------
	Settings
	--------------------------
	You may change these ...
------------------------------ */


// enable to have functions generated for each group- or pathitem
var generateFunctions = true;

// enable to have full shapes generated instead of line and bezier segments
var generateShapes = true;

// enable to round all values to int
var intValues = true;

// enable to have additional comments added to the sketch
var chatty = true;


/* ---------------------------
	Library
------------------------------ */

var nl  = "\r";
var tab = "    ";
var pathNum = 0;
var groupNum = 0;

var DEBUG = false;

var groupItemToP5 = function ( groupItem )
{
	var pCode = nl;
	
	//var left = groupItem.left;
	//var top =  groupItem.top;
	
	var left = groupItem.geometricBounds[0];
	var top  = groupItem.geometricBounds[1];
	
	groupNum++;
	
	var grpName = "groupItem";
		
	if ( groupItem.name != "" && groupItem.name != undefined )
		grpName = sanitizeName( groupItem.name );
	else if ( groupItem.parent.name != "" && groupItem.parent.name != undefined )
		grpName = sanitizeName( groupItem.parent.name );
	
	if ( intValues )
	{
		left = Math.round( left );
		top = Math.round( top );
	}
	
	if ( generateFunctions )
	{
		pCode = pCode + "float[] drawGroup_" + groupNum + '_' + grpName + " ( float x, float y ) {" +nl;
	}
	
	if ( chatty )
		pCode = pCode + '// group #' + groupNum + ' "'+ groupItem.name +'" start' +nl;
	
	pCode = pCode + 'pushMatrix();' +nl;
	
	if ( chatty ) 
		pCode = pCode + tab + '//translate( ' + left + ', height-' + top + ' );' + nl;
	
	if ( generateFunctions )
	{
		pCode = pCode + tab + 'translate( x, y );' + nl;
	}
	else if ( chatty )
	{
		pCode = pCode + tab + '/* put a translate here to move group around */' + nl;
		pCode = pCode + tab + '//translate(  ,  );' + nl;
	}
	
	for (var i = 0; i < groupItem.pathItems.length; i++)
	{
		if ( chatty )
			pCode = pCode + tab + '// path item #'+i+' of group #' + groupNum + ' "'+ groupItem.name + '"' + nl;
		
		pCode = pCode + pathItemToP5( groupItem.pathItems[i], left, top, true );
	}
	
	pCode = pCode + 'popMatrix();' +nl;
	if ( chatty )
		pCode = pCode + '// group ' + groupNum + ' "'+ groupItem.name +'" end' +nl;
	pCode = pCode + nl;
	
	if ( generateFunctions )
	{
		var bbox = groupItem.geometricBounds;
		
		var w = (bbox[2]-left);
		var h = ((bbox[3]-top)*-1);
		
		if ( intValues ) {
			w = Math.round(w);
			h = Math.round(h);
		}
		
		pCode = pCode + tab + 'return new float[]{' + w + ' , ' + h + '};' + nl;
				  
		pCode = pCode + '}' +nl;
	}
	
	return pCode;
}


var pathItemToP5 = function ( pathItem, pLeft, pTop, inGroup )
{
	var pCode = '';
	
	var pthName = "pathItem";
		
	if ( pathItem.name != "" && pathItem.name != undefined )
		pthName = sanitizeName( pathItem.name );
	else if ( pathItem.parent.name != "" && pathItem.parent.name != undefined )
		pthName = sanitizeName( pathItem.parent.name );
	
	pathNum++;
	
	if ( pathItem == undefined || pathItem.hidden || pathItem.guides || (!inGroup && pathItem.parent.typename == 'GroupItem') ) return !DEBUG ? '' : '/* null, hidden or guide path item skipped */' + nl;
	
	if ( !inGroup )
	{
		// var left = pathItem.left;
		// var top =  pathItem.top;
	
		var left = pathItem.geometricBounds[0];
		var top  = pathItem.geometricBounds[1];
	
		if ( chatty )
			pCode = pCode + tab + '// path item ' + pathNum + ' "' + pathItem.name + '"' + nl;
	}
	else
	{
		var left =  pLeft;
		var top =   pTop;
	}
	
	if ( intValues )
	{
		left = Math.round( left );
		top = Math.round( top );
	}
	
	if ( generateFunctions && !inGroup && pathItem.parent.typename !== 'GroupItem' )
	{
		pCode = pCode + "float[] drawPath_"+pathNum+"_"+pthName+" ( float x, float y ) {" +nl;
	}
	
	pCode = pCode + tab + 'pushMatrix();' +nl;
	
	if ( chatty && !inGroup )
		pCode = pCode + tab + tab + '//translate( ' + left + ', height-' + top + ' );' +nl;
	
	if ( generateFunctions && !inGroup && pathItem.parent.typename !== 'GroupItem' )
	{
		pCode = pCode + tab + tab + 'translate( x, y );' +nl;
	}
	else if ( !generateFunctions && chatty )
	{
		pCode = pCode + tab + '/* put a translate here to move path item around */' + nl;
		pCode = pCode + tab + '//translate(  ,  );' + nl;
	}
	
	
	// --
	
	if ( pathItem.stroked )
	{
		
		pCode = pCode + tab + tab + 'strokeWeight(' + pathItem.strokeWidth + ');' +nl;
			
		if ( pathItem.strokeColor.typename == 'RGBColor' )
			pCode = pCode + tab + tab + 'stroke(' +  pathItem.strokeColor.red + ' , ' + 
													 pathItem.strokeColor.green + ' , ' + 
													 pathItem.strokeColor.blue + ' , ' + 
													(pathItem.opacity * 2.55) + ');' +nl;
		else if ( pathItem.strokeColor.typename == 'GrayColor' )
			pCode = pCode + tab + tab + 'fill(' + (pathItem.strokeColor.gray * 2.55) + ' , ' + 
												  (pathItem.opacity * 2.55) + ');' +nl;
	}
	else
		pCode = pCode + tab + tab + 'noStroke();' +nl;
	
	if ( pathItem.filled )
	{
		if ( pathItem.fillColor.typename == 'RGBColor' )
			pCode = pCode + tab + tab + 'fill(' +  pathItem.fillColor.red + ' , ' + 
												   pathItem.fillColor.green + ' , ' + 
												   pathItem.fillColor.blue + ' , ' + 
												  (pathItem.opacity * 2.55) + ');' +nl;
		else if ( pathItem.fillColor.typename == 'GrayColor' )
			pCode = pCode + tab + tab + 'fill(' + (pathItem.fillColor.gray * 2.55) + ' , ' + 
												  (pathItem.opacity * 2.55) + ');' +nl;
	}
	else
		pCode = pCode + tab + tab + 'noFill();' +nl;
	
	var pp = pathItem.pathPoints[0];
	
	if ( generateShapes )
	{
		pCode = pCode + tab + tab + 'beginShape();' +nl;
	
		pCode = pCode + tab + genP5vertex( (pp.anchor[0] - left) , ((pp.anchor[1] - top ) * -1) ) + nl;
	}
	
	for ( var ii = 1; ii < pathItem.pathPoints.length; ii++ )
	{
		var p0 = pathItem.pathPoints[ii-1];
		var p1 = pathItem.pathPoints[ii];
		
		if (    p0.anchor[0] != p0.rightDirection[0] || p0.anchor[1] != p0.rightDirection[1]
			 || p1.anchor[0] != p1.leftDirection[0]  || p1.anchor[1] != p1.leftDirection[1]  )
		{
			if ( generateShapes ) 
			{
				pCode = pCode + tab + tab + 
						genP5bezierVertex ( 
							(p0.rightDirection[0] - left) , ((p0.rightDirection[1] - top) * -1) , 
							(p1.leftDirection[0]  - left) , ((p1.leftDirection[1]  - top) * -1) , 
							(p1.anchor[0]         - left) , ((p1.anchor[1]         - top) * -1)  
						) + nl;
			}
			else
			{
				pCode = pCode + tab + tab + 
					genP5bezier ( 
						(p0.anchor[0] - left) 		  , ((p0.anchor[1] - top) * -1) , 
						(p0.rightDirection[0] - left) , ((p0.rightDirection[1] - top) * -1) , 
						(p1.leftDirection[0]  - left) , ((p1.leftDirection[1]  - top) * -1) , 
						(p1.anchor[0]         - left) , ((p1.anchor[1]         - top) * -1)  
					) + nl;
			}
		}
		else
		{
			if ( generateShapes )
				pCode = pCode + tab + tab + genP5vertex( (p1.anchor[0] - left) , ((p1.anchor[1] - top) * -1) ) + nl;
			else
				pCode = pCode + tab + tab + genP5line( (p0.anchor[0] - left) , ((p0.anchor[1] - top) * -1) ,
												 (p1.anchor[0] - left) , ((p1.anchor[1] - top) * -1) ) + nl;
		}
	}
	
	if ( pathItem.closed  )
	{
		pl = pathItem.pathPoints[pathItem.pathPoints.length-1];
		
		if (   pp.anchor[0] != pp.leftDirection[0]  || pp.anchor[1] != pp.leftDirection[1]
			|| pl.anchor[0] != pl.rightDirection[0] || pl.anchor[1] != pl.rightDirection[1]
		)
		{
			if ( generateShapes ) 
			{
				pCode = pCode + tab + tab + 
						genP5bezierVertex ( 
							(pl.rightDirection[0] - left) , ((pl.rightDirection[1] - top) * -1) , 
							(pp.leftDirection[0]  - left) , ((pp.leftDirection[1]  - top) * -1) , 
							(pp.anchor[0]         - left) , ((pp.anchor[1]         - top) * -1)  
						) + nl;
			}
			else
			{
				pCode = pCode + tab + tab + 
					genP5bezier ( 
						(pl.anchor[0] - left) 		  , ((pl.anchor[1] - top) * -1) , 
						(pl.rightDirection[0] - left) , ((pl.rightDirection[1] - top) * -1) , 
						(pp.leftDirection[0]  - left) , ((pp.leftDirection[1]  - top) * -1) , 
						(pp.anchor[0]         - left) , ((pp.anchor[1]         - top) * -1)  
					) + nl;
			}
		}
		else
		{
			if ( generateShapes ) 
				pCode = pCode + tab + 'endShape( CLOSE );' +nl;
			else
				pCode = pCode + tab + tab + genP5line( (pl.anchor[0] - left) , ((pl.anchor[1] - top) * -1) ,
											 (pp.anchor[0] - left) , ((pp.anchor[1] - top) * -1) ) + nl;
		}
	}
	else if ( generateShapes ) 
		pCode = pCode + tab + 'endShape();' +nl;
		
	// --
	
	pCode = pCode + tab + 'popMatrix();' +nl;
	pCode = pCode + nl;
	
	if ( generateFunctions && !inGroup && pathItem.parent.typename !== 'GroupItem' )
	{
		var bbox = pathItem.geometricBounds;
		
		var w = (bbox[2]-left);
		var h = ((bbox[3]-top)*-1);
		
		if ( intValues ) {
			w = Math.round(w);
			h = Math.round(h);
		}
		
		pCode = pCode + tab + 'return new float[]{' + w + ' , ' + h + '};' + nl;
				  
		pCode = pCode + '}' +nl;
	}
	
	pCode = pCode + nl;
	
	return pCode;
}


var genP5bezier = function ( xs, ys, ax, ay, bx, by, xe, ye )
{
	if ( intValues )
	{
		xs = Math.round( xs );
		ys = Math.round( ys );
		ax = Math.round( ax );
		ay = Math.round( ay );
		bx = Math.round( bx );
		by = Math.round( by );
		xe = Math.round( xe );
		ye = Math.round( ye );
	}
	
	return 'bezier( ' + xs + ' , ' + ys + ' , ' + 
						ax + ' , ' + ay + ' , ' + bx + ' , ' + by + ' , ' + 
						xe + ' , ' + ye + ');';
}

var genP5line = function ( xs, ys, xe, ye )
{
	if ( intValues )
	{
		xs = Math.round( xs );
		ys = Math.round( ys );
		xe = Math.round( xe );
		ye = Math.round( ye );
	}
	return 'line( ' + xs + ' , ' + ys + ' , ' + xe + ' , ' + ye + ' );';
}

var genP5bezierVertex = function ( ax, ay, bx, by, x, y )
{
	if ( intValues )
	{
		ax = Math.round( ax );
		ay = Math.round( ay );
		bx = Math.round( bx );
		by = Math.round( by );
		x  = Math.round( x );
		y  = Math.round( y );
	}
	return 'bezierVertex( ' + ax + ' , ' + ay + ' , ' + bx + ' , ' + by + ' , ' + x + ' , ' + y + ');';
}

var genP5vertex = function ( x, y )
{
	if ( intValues )
	{
		x  = Math.round( x );
		y  = Math.round( y );
	}
	return 'vertex( ' + x + ' , ' + y + ' );';
}

var sanitizeName = function ( name )
{
	name = name.replace( /[\u00DC]{1}/g, 'Ue' );
	name = name.replace( /[\u00FC]{1}/g, 'ue' );
	name = name.replace( /[\u00D6]{1}/g, 'Oe' );
	name = name.replace( /[\u00F6]{1}/g, 'oe' );
	name = name.replace( /[\u00C4]{1}/g, 'Ae' );
	name = name.replace( /[\u00E4]{1}/g, 'ae' );
	name = name.replace( /[\u00DF]{1}/g, 'ss' );
	name = name.replace( /[^a-zA-Z0-9_]{1}/g, '_' );
	
	return name;
}


/* ----------------------------
	Main
------------------------------- */

// a document open?

if ( app.documents.length > 0 )
{
	
	var pageItems = app.activeDocument.pageItems; // items in document
	
	// any items on page?
	
	if ( pageItems.length > 0 )
	{
		var pdeTxt = nl;
		
		pdeTxt = pdeTxt + '/** Exported with Ai2Processing on ' + Date() + ' **/' + nl;
		pdeTxt = pdeTxt + '/** See: http://bezier.de/processing/ai2p/ **/' + nl + nl;
		
		if ( !generateFunctions )
		{
			if ( chatty ) {
				pdeTxt = pdeTxt + '// size is set to width and height of the box that surrounds all elements (bounding box) of the illustration.' + nl;
				pdeTxt = pdeTxt + '// you can see this bounding box when you select-all in illustrator.' + nl;
			}
			pdeTxt = pdeTxt + 'size( ' + Math.abs(Math.round(app.activeDocument.geometricBounds[2])) + ' , ' +
									   + Math.abs(Math.round(app.activeDocument.geometricBounds[3]+app.activeDocument.geometricBounds[1])) + ');'  + nl;
		
			/*if ( chatty ) 
			{
				if ( generateFunctions )
					pdeTxt = pdeTxt + 'float[] translateDocument ( x, y ) {' + nl;
				
				pdeTxt = pdeTxt + tab + '// translates to top-left position of the bounding box' + nl;
				pdeTxt = pdeTxt + tab + 'translate( ' + Math.round(app.activeDocument.geometricBounds[0]) + ' , ' +
								        	          + Math.round(app.activeDocument.geometricBounds[1]) + ');'  + nl;
				if ( generateFunctions )
				{
					pdeTxt = pdeTxt + tab + 'return new float[]{ ' + Math.round(app.activeDocument.geometricBounds[0]) + ' , ' +
								        	        		 	   + Math.round(app.activeDocument.geometricBounds[1]) + '};'  + nl;
					pdeTxt = pdeTxt + '}' + nl;
				}
			}*/
		}
		
		for ( var i = 0; i < pageItems.length; i++ )
		{		
			if (    pageItems[i].typename == 'PathItem'
				 && pageItems[i].pathPoints.length > 1 )
			{
				// is path item ? has more than 1 point in it?
				
				pdeTxt = pdeTxt + pathItemToP5( pageItems[i], -1, -1, false );
			}
			else if (    pageItems[i].typename == 'GroupItem'
					  && pageItems[i].pathItems.length > 0 )
			{
				// group? has it pathItems?
				
				pdeTxt = pdeTxt + groupItemToP5( pageItems[i] );
			}
			
		}  // loop page items
		
		// replace any char in the documents name that's not 0-9 or A-Z with "_"
		var p5Name = (app.activeDocument.name + "").replace(/[^a-zA-Z0-9_]{1}.*\.[a-zA-Z]{2,}$/g,'_');
		
		// replace documents name in full path with p5Name and add ".pde" extension
		var pdeFile = new File ( (app.activeDocument.fullName + "").replace( app.activeDocument.name, p5Name ).replace(/\.[a-zA-Z]{2,}$/,'.pde') );
		
		if ( pdeTxt !== "" && pdeFile != null && pdeFile instanceof File )
		{
			if ( pdeFile.open('w') )
			{
				if ( pdeFile.write(pdeTxt) )
				{
					pdeFile.close();
				}
			}
		}
		else
		{
			alert( pdeFile.error ? pdeFile.error : 'Error saving .pde file' );
		}
		
	}
	else // no items, blank page
	{
		alert( 'Nothing here.' );
	}
}
else // no doc
{
	alert( 'You need to have a document open.' );
}