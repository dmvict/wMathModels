(function _Plane_s_(){

'use strict';

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var Self = _.plane = _.plane || Object.create( null );

// --
//
// --

function make( dim )
{
  if( dim === undefined )
  dim = 3;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );
  var dst = _.dup( 0,dim+1 );
  return dst;
}

//

function _from( plane )
{
  _.assert( _.plane.is( plane ) );
  _.assert( _.vectorIs( plane ) || _.arrayLike( plane ) );
  _.assert( arguments.length === 1 );
  return _.vector.from( plane );
}

//

function is( plane )
{
  _.assert( arguments.length === 1 );
  return ( _.arrayLike( plane ) || _.vectorIs( plane ) ) && plane.length >= 1;
}

//


/**
* Create a plane from another plane or a normal and a bias. Returns the new plane.
* Planes are stored in Array data structure. Source plane/Normal and bias stay untouched, dst plane changes.
*
* @param { Array } dstplane - Destination plane to be expanded.
* @param { Array } srcplane - Source plane.
* Alternative to srcplane:
* @param { Array } normal - Array of points with normal vector coordinates.
* @param { Number } bias - Number with bias value.
*
* @example
* // returns [ 0, 0, 1, 2 ];
* _.from( [ 0, 0, 0, 0 ] , [ 0, 0, 1, 2 ] );
*
* @example
* // returns [ 0, - 1, 2, 2 ];
* _.from( [ 0, 0, 1, 1 ], [ 0, - 1, 2 ], 2 );
*
* @returns { Array } Returns the array of the new plane.
* @function from
* @throws { Error } An Error if ( arguments.length ) is different than two or three.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( normal ) is not array.
* @throws { Error } An Error if ( bias ) is not number.
* @memberof wTools.box
*/

function from( plane )
{

  if( plane === null )
  plane = _.plane.make();

  _.assert( arguments.length === 2 || arguments.length === 3 );
  debugger;
  // throw _.err( 'not tested' );

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  if( arguments.length === 2 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    _.avector.assign( _plane,arguments[ 1 ] )
  }
  else if( arguments.length === 3 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    _.avector.assign( normal,vector.from( arguments[ 1 ] ) );
    _.plane.biasSet( _plane,arguments[ 2 ] );
  }
  else _.assert( 0,'unexpected arguments' );

  return plane;
}

//

function fromNormalAndPoint( plane, anormal, apoint )
{

  if( plane === null )
  plane = _.plane.make();

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 3 );
  debugger;
  //throw _.err( 'not tested' );

  debugger;
  normal.copy( anormal );
  _.plane.biasSet( plane , - _.vector.dot( _.vector.from( apoint ) , normal ) );

  return plane;
}

//

function fromPoints( plane,a,b,c )
{

  if( plane === null )
  plane = _.plane.make();

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 4 );
  debugger;
  //throw _.err( 'not tested' );

  a = _.vector.from( a );
  b = _.vector.from( b );
  c = _.vector.from( c );

  var n1 = vector.subVectors( a.clone() , b );
  var n2 = vector.subVectors( c.clone() , b );
  var normal = vector.cross( n1,n2 );
  debugger;
  normal.normalize();

  _.plane.fromNormalAndPoint( plane, normal, a );

  return plane;
}

//

function dimGet( plane )
{
  var dim = plane.length - 1;

  _.assert( _.plane.is( plane ) );
  _.assert( arguments.length === 1 );

  debugger;

  return dim;
}

//

function normalGet( plane )
{
  var _plane = _.plane._from( plane );
  _.assert( arguments.length === 1 );
  return _plane.subarray( 0,_plane.length-1 );
}

//

function biasGet( plane )
{
  var _plane = _.plane._from( plane );
  _.assert( arguments.length === 1 );
  return _plane.eGet( _plane.length-1 );
}

//

function biasSet( plane,bias )
{
  var _plane = _.plane._from( plane );

  _.assert( _.numberIs( bias ) );
  _.assert( arguments.length === 2 );
  debugger;
  //throw _.err( 'not tested' );

  return _plane.eSet( _plane.length-1,bias );
}

//

function pointDistance( plane , point )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );
  var _point = _.vector.fromArray( point );

  _.assert( arguments.length === 2 );

  return _.vector.dot( normal , point ) + bias;
}

//

function pointCoplanarGet( plane , point )
{

  if( !point )
  point = [ 0,0,0 ];

  var _point = _.vector.fromArray( point );
  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger;
  throw _.err( 'not tested' );

  _.avector.assign( _point , normal  );
  _.avector.mulScalar( -bias );

  return point
}

//

function sphereDistance( plane , sphere )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
  throw _.err( 'not tested' );

  var d = _.plane.pointDistance( plane , sphere );
  return d - _.sphere.radiusGet( sphere );
}

//

function lineIntersects( plane , line )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
  throw _.err( 'not tested' );

  var b = _.plane.pointDistance( line[ 0 ] );
  var e = _.plane.pointDistance( line[ 1 ] );

  debugger;
  return ( b <= 0 && e >= 0 ) || ( e <= 0 && b >= 0 );
}

//

function lineIntersection( plane , line , point )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 3 );
  debugger;
  throw _.err( 'not tested' );

  if( point === null )
  point = [ 0,0,0 ];

  var direction = _.line.pointDirection( point );

  var dot = _.vector.dot( normal , direction );

  if( Math.abs( dot ) < _.EPS2 )
  {

    if( _.plane.pointDistance( plane, line[ 0 ] ) < _.EPS2 )
    {
      _.avector.assign( point,line[ 0 ] );
      return point
    }

    return false;
  }

  var t = - ( _.vector.dot( line[ 0 ] , this.normal ) + bias ) / dot;

  if( t < 0 || t > 1 )
  return false;

  return _.line.at( [ line[ 0 ],direction ] , t );
}

//

function matrixHomogenousApply( plane , matrix )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
  throw _.err( 'not tested' );

  normal = normal.clone();

  /* var m = m1.normalProjectionMatrixGet( matrix ); */

  if( matrix.ncol === 4 )
  matrix = matrix.normalProjectionMatrixMake();

  normal = _.space.mul( matrix,normal );

  var point = _.plane.pointCoplanarGet( plane );
  matrix.matrixHomogenousApply( point );

  return _.plane.fromNormalAndPoint( plane , normal , point );
}

//

function translate( plane , offset )
{

  var _offset = _.vector.fromArray( offset );
  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 2 );
  debugger;
  throw _.err( 'not tested' );

  _.plane.biasSet( bias - _.vector.dot( normal,_offset ) )

  return plane;
}

//

function normalize( plane )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1 );
  debugger;
  throw _.err( 'not tested' );

  var scaler = 1.0 / normal.mag();
  normal.mulScalar( scaler );
  _.plane.biasSet( _plane,bias*scaler );

  return plane;
}

//

function negate( plane )
{

  var _plane = _.plane._from( plane );
  var normal = _.plane.normalGet( _plane );
  var bias = _.plane.biasGet( _plane );

  _.assert( arguments.length === 1 );
  debugger;
  throw _.err( 'not tested' );

  _.vector.mulScalar( normal,-1 );
  _.plane.biasSet( _plane,-bias );

  return plane;
}

// --
// define class
// --

var Proto =
{

  make : make,
  _from : _from,
  is : is,

  from : from,
  fromNormalAndPoint : fromNormalAndPoint,
  fromPoints : fromPoints,

  dimGet : dimGet,
  normalGet : normalGet,
  biasGet : biasGet,
  biasSet : biasSet,

  pointDistance : pointDistance,
  pointCoplanarGet : pointCoplanarGet,

  sphereDistance : sphereDistance,

  lineIntersects : lineIntersects,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

  normalize : normalize,
  negate : negate,

}

_.mapSupplement( Self,Proto );

})();
