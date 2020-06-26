if( typeof module !== 'undefined' )
require( 'wmathmodels' );

var _ = wTools;

/* */

var plane = [ 1, 0, 0, 1 ];
var capsule = [ - 1, 2, 3, -1, 2, 3, 0  ];
var intersected = _.plane.capsuleIntersects( plane, capsule );
console.log( `Plane intersects with capsule : ${ intersected }` );
/* log : Plane intersects with capsule: true */
