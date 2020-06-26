if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var line = [ 2, 1, 4, 2 ];
var point = [ 2, 3 ];
var distance = _.linePoints.pointDistance( line, point );
console.log( `Distance from line to point : ${ _.toStr( distance, { precision : 2 } ) }` );
/* log : Distance from line to point : 1.8 */
