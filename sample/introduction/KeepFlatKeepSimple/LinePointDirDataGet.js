
if( typeof module !== 'undefined' )
var _ = require( '../../..' );

var _ = wTools;

//Отримання початкової точки лінії
var line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
var origin = _.linePointDir.originGet( line );
console.log( 'Origin: ', origin.toStr() );
/* log : Origin : "1.000 2.000" */

//Отримання вектору напрямку
var line = _.linePointDir.from( [ 1, 2, 3, 4 ] );
var direction = _.linePointDir.directionGet( line );
console.log( 'Direction: ', direction.toStr() );
/* log : Origin : "3.000 4.000" */