(function _Euler_s_(){

'use strict';

/*
*/

var _ = _global_.wTools;
var avector = _.avector;
var vector = _.vector;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var atan2 = Math.atan2;
var asin = Math.asin;
var acos = Math.acos;
var abs = Math.abs;
var sqr = _.sqr;
var sqrt = _.sqrt;
var clamp = _.clamp;

_.assert( clamp )
_.assert( !_.euler );

var Self = _.euler = _.euler || Object.create( _.avector );

// --
//
// --

function is( euler )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  return ( _.longIs( euler ) || _.vectorIs( euler ) ) && ( euler.length === 6 );
}

//

function isZero( euler )
{

  _.assert( arguments.length === 1, 'expects single argument' );

  var eulerv = _.euler._from( euler );

  for( var d = 0 ; d < 3 ; d++ )
  if( eulerv.eGet( d ) !== 0 )
  return false;

  return true;
}

//

function make( srcEuler, representation )
{
  var result = _.euler.makeZero();

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( srcEuler === undefined || srcEuler === null || _.euler.is( srcEuler ) );
  _.assert( representation === undefined || representation );

  if( _.euler.is( srcEuler ) )
  _.avector.assign( result, srcEuler );

  if( representation )
  _.euler.representationSet( result, representation );

  return result;
}

//

function makeZero( representation )
{
  var result = _.dup( 0,6 );
  result[ 3 ] = 0;
  result[ 4 ] = 1;
  result[ 5 ] = 2;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( representation === undefined || representation );

  if( representation )
  _.euler.representationSet( result, representation );

  return result;
}

//

function zero( euler )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( euler === undefined || euler === null || _.euler.is( euler ) );

  if( _.euler.is( euler ) )
  {
    var eulerv = _.euler._from( euler );
    for( var i = 0 ; i < 3 ; i++ )
    eulerv.eSet( i,0 );
    return euler;
  }

  return _.euler.makeZero();
}

//

function from( euler )
{

  _.assert( euler === null || _.euler.is( euler ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  if( euler === null )
  return _.euler.make();

  if( _.vectorIs( euler ) )
  {
    debugger;

    //throw _.err( 'not implemented' );
    // return euler.slice();
    return euler.toArray();
  }

  return euler;
}

//

function _from( euler )
{
  _.assert( _.euler.is( euler ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  return _.vector.from( euler );
}

//

function representationSet( dstEuler, representation )
{
  var dstEulerVector = _.euler._from( dstEuler );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  if( _.arrayIs( representation ) )
  {
    _.assert( representation.length === 3 );
    var rep = true;
    for( var i = 0; i < 3; i++ )
    {
      if( representation[ i ] !== 0 && representation[ i ] !== 1 && representation[ i ] !== 2 )
      {
        rep = false;
      }
    }

    if( rep )
    {
      dstEulerVector.eSet( 3, representation[ 0 ] );
      dstEulerVector.eSet( 4, representation[ 1 ] );
      dstEulerVector.eSet( 5, representation[ 2 ] );
    }
    else _.assert( 0, 'Not an Euler Representation' );
  }
  else if( _.strIs( representation ) )
  {

    if( representation === 'xyz' )
    {
      dstEulerVector.eSet( 3, 0 );
      dstEulerVector.eSet( 4, 1 );
      dstEulerVector.eSet( 5, 2 );
    }
    else if( representation === 'xzy' )
    {
      dstEulerVector.eSet( 3, 0 );
      dstEulerVector.eSet( 4, 2 );
      dstEulerVector.eSet( 5, 1 );
    }
    else if( representation === 'yxz' )
    {
      dstEulerVector.eSet( 3, 1 );
      dstEulerVector.eSet( 4, 0 );
      dstEulerVector.eSet( 5, 2 );
    }
    else if( representation === 'yzx' )
    {
      dstEulerVector.eSet( 3, 1 );
      dstEulerVector.eSet( 4, 2 );
      dstEulerVector.eSet( 5, 0 );
    }
    else if( representation === 'zxy' )
    {
      dstEulerVector.eSet( 3, 2 );
      dstEulerVector.eSet( 4, 0 );
      dstEulerVector.eSet( 5, 1 );
    }
    else if( representation === 'zyx' )
    {
      dstEulerVector.eSet( 3, 2 );
      dstEulerVector.eSet( 4, 1 );
      dstEulerVector.eSet( 5, 0 );
    }
    else if( representation === 'xyx' )
    {
      dstEulerVector.eSet( 3, 0 );
      dstEulerVector.eSet( 4, 1 );
      dstEulerVector.eSet( 5, 0 );
    }
    else if( representation === 'xzx' )
    {
      dstEulerVector.eSet( 3, 0 );
      dstEulerVector.eSet( 4, 2 );
      dstEulerVector.eSet( 5, 0 );
    }
    else if( representation === 'yxy' )
    {
      dstEulerVector.eSet( 3, 1 );
      dstEulerVector.eSet( 4, 0 );
      dstEulerVector.eSet( 5, 1 );
    }
    else if( representation === 'yzy' )
    {
      dstEulerVector.eSet( 3, 1 );
      dstEulerVector.eSet( 4, 2 );
      dstEulerVector.eSet( 5, 1 );
    }
    else if( representation === 'zxz' )
    {
      dstEulerVector.eSet( 3, 2 );
      dstEulerVector.eSet( 4, 0 );
      dstEulerVector.eSet( 5, 2 );
    }
    else if( representation === 'zyz' )
    {
      dstEulerVector.eSet( 3, 2 );
      dstEulerVector.eSet( 4, 1 );
      dstEulerVector.eSet( 5, 2 );
    }
    else _.assert( 0, 'Not an Euler Representation', _.strQuote( representation ) );
  }
  else _.assert( 0, 'unknown type of {-representation-}', _.strTypeOf( representation ) )

  return dstEuler;
}

//

/*
  double s=Math.sin(angle);
  double c=Math.cos(angle);
  double t=1-c;
  //  if axis is not already normalised then uncomment this
  // double magnitude = Math.sqrt(x*x + y*y + z*z);
  // if(magnitude==0) throw error;
  // x /= magnitude;
  // y /= magnitude;
  // z /= magnitude;
  if((x*y*t + z*s) > 0.998) { // north pole singularity detected
    heading = 2*atan2(x*Math.sin(angle/2),Math.cos(angle/2));
    attitude = Math.PI/2;
    bank = 0;
    return;
  }
  if((x*y*t + z*s) < -0.998) { // south pole singularity detected
    heading = -2*atan2(x*Math.sin(angle/2),Math.cos(angle/2));
    attitude = -Math.PI/2;
    bank = 0;
    return;
  }
  heading = Math.atan2(y * s- x * z * t , 1 - (y*y+ z*z ) * t);
  attitude = Math.asin(x * y * t + z * s) ;
  bank = Math.atan2(x * s - y * z * t , 1 - (x*x + z*z) * t);
*/

function fromAxisAndAngle( dst, axis, angle )
{

  dst = _.euler.from( dst );
  var dstv = _.vector.from( dst );
  var axisv = _.vector.from( axis );

  if( angle === undefined )
  angle = axis[ 3 ];

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( axis.length === 3 || axis.length === 4 );
  _.assert( _.numberIs( angle ) );
  _.assert( this.accuracy > 0 );

  var s = sin( angle );
  var c = cos( angle );
  var t = 1-c;

  var x = axisv.eGet( 0 );
  var y = axisv.eGet( 1 );
  var z = axisv.eGet( 2 );

  if( ( x*y*t + z*s ) > 1-this.accuracy )
  {
    xxx
    dstv.eSet( 0, 2*atan2( x*sin( angle/2 ),cos( angle/2 ) ) );
    dstv.eSet( 1, Math.PI/2 );
    dstv.eSet( 2, bank = 0 );
    return dst;
  }
  else if( ( x*y*t + z*s ) < -1+this.accuracy )
  {
    yyy
    dstv.eSet( 0, -2*atan2( x*sin( angle/2 ),cos( angle/2 ) ) );
    dstv.eSet( 1, -Math.PI/2 );
    dstv.eSet( 2, bank = 0 );
    return dst;
  }

  var x2 = x*x;
  var y2 = y*y;
  var z2 = z*z;

  // xyz

  dstv.eSet( 0, atan2( y*s - x*z*t , 1 - ( y2 + z2 ) * t ) );
  dstv.eSet( 1, asin( x*y*t + z*s ) );
  dstv.eSet( 2, atan2( x*s - y*z*t , 1 - ( x2 + z2 ) * t ) );

  // xzy

  dstv.eSet( 0, atan2( z*s - x*y*t , 1 - ( z2 + y2 ) * t ) );
  dstv.eSet( 1, atan2( x*s - z*y*t , 1 - ( x2 + y2 ) * t ) );
  dstv.eSet( 2, asin( x*z*t + y*s ) );

  return dst;
}

//

function fromQuat( dst, quat, v )
{
  var /*eps*/accuracy = 1e-9;
  var half = 0.5-/*eps*/accuracy;

  var dst = _.euler.from( dst );
  var dstv = _.vector.from( dst );
  var quatv = _.quat._from( quat );

  // _.assert( arguments.length === 2, 'expects exactly two arguments' );

  var ox = dstv.eGet( 3 );
  var oy = dstv.eGet( 4 );
  var oz = dstv.eGet( 5 );
  var same = ox === oz;

  var sign;

  // if( same )
  // {
  //   if( 0 !== ox && 0 !== oy )
  //   oz = 0;
  //   else if( 1 !== ox && 1 !== oy )
  //   oz = 1;
  //   else if( 2 !== ox && 2 !== oy )
  //   oz = 2;
  //   sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  // }
  // else
  // {
    sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  // }

  sign = sign ? -1 : + 1;
  // console.log( 'sign',sign );

  var ex,ey,ez;

  // var x = quatv.eGet( ox );
  // var y = quatv.eGet( oy );
  // var z = quatv.eGet( oz );
  // var w = quatv.eGet( 3 );

  var x = quatv.eGet( 0 );
  var y = quatv.eGet( 1 );
  var z = quatv.eGet( 2 );
  var w = quatv.eGet( 3 );

  var sqx = x*x;
  var sqy = y*y;
  var sqz = z*z;
  var sqw = w*w;

  //

  // xyx
  // psi = atan2((q[1] * q[2] + q[3] * q[0]), (q[2] * q[0] - q[1] * q[3]));
  // theta = acos(q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[2] - q[3] * q[0]), (q[1] * q[3] + q[2] * q[0]));

  // xzx
  // psi = atan2((q[1] * q[3] - q[2] * q[0]), (q[1] * q[2] + q[3] * q[0]));
  // theta = acos(q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[3] + q[2] * q[0]), (q[3] * q[0] - q[1] * q[2]));

  // yxy
  // psi = atan2((q[1] * q[2] - q[3] * q[0]), (q[1] * q[0] + q[2] * q[3]));
  // theta = acos(q[0] * q[0] - q[1] * q[1] + q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[2] + q[3] * q[0]), (q[1] * q[0] - q[2] * q[3]));

//   if( same )
//   {
//
//     // sign = 1;
//     dstv.eSet( 0, atan2( ( x * y + sign * z * w ) , ( y * w - sign * x * z ) ) );
//     dstv.eSet( 1, acos( sqw + sqx - sqy - sqz ) );
//     dstv.eSet( 2, atan2( ( x * y - sign * z * w ) , ( y * w + sign * x * z ) ) );
//
//   }
//   else
//   {
//
//     // var test = ( v.xz1*x*z + v.yw1*y*w );
//     var test = ( x*z - y*w );
//
//     if( test > +half )
//     {
//       xxx
//       dstv.eSet( ox, +2 * Math.atan2( z,w ) );
//       dstv.eSet( oy, +Math.PI / 2 );
//       dstv.eSet( oz, 0 );
//     }
//     else if( test < -half )
//     {
//       yyy
//       dstv.eSet( ox, -2 * Math.atan2( z,w ) );
//       dstv.eSet( oy, -Math.PI / 2 );
//       dstv.eSet( oz, 0 );
//     }
//     else
//     {
//       // dstv.eSet( ox, sign * atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, sign * asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( oz, sign * atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       dstv.eSet( 0, sign * atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       dstv.eSet( 2, sign * atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       // dstv.eSet( 0, atan2( 2 * ( v.xw0 * x * w + v.yz0 * y * z ) , ( v.sqw0*sqw + v.sqx0*sqx + v.sqy0*sqy + v.sqz0*sqz ) ) );
//       // dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( 2, atan2( 2 * ( v.zw2 * z * w + v.xy2 * x * y ) , ( v.sqw2*sqw + v.sqx2*sqx + v.sqy2*sqy + v.sqz2*sqz ) ) );
//
//       // dstv.eSet( 0, atan2( 2 * ( x * w + v.yz0 * y * z ) , ( v.sqw0*sqw + v.sqx0*sqx + v.sqy0*sqy + v.sqz0*sqz ) ) );
//       // dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( 2, atan2( 2 * ( v.zw2 * z * w + v.xy2 * x * y ) , ( v.sqw2*sqw + v.sqx2*sqx + v.sqy2*sqy + v.sqz2*sqz ) ) );
//
// // trivial xyz sample :
// // {
// //   xw0 : 1,
// //   yz0 : -1,
// //   xz1 : 1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : -1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial xzy sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : -1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial zyx sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : -1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial zyx sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : 1,
// //   yw1 : -1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
//
//       // var x = quatv.eGet( 0 );
//       // var y = quatv.eGet( 1 );
//       // var z = quatv.eGet( 2 );
//       // var w = quatv.eGet( 3 );
//
//       // dstv.eSet( ox, -sign * atan2( 2 * ( x * w + y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, -asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( oz, sign * atan2( 2 * ( z * w - x * y ) , ( sqw - sqx - sqy + sqz ) ) );
//
//       // dstv.eSet( ox, atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( x*z + y*w ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       // dstv.eSet( ox, atan2( 2 * ( z*w - x*y ) , ( sqw + sqx - sqy - sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( x*w - y*z ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( ( sqw - sqx - sqy + sqz ) , 2 * ( x*z + w*y ) ) );
//
//       // /* xzy */
//       //
//       // var sign = 1;
//       // dstv.eSet( ox, atan2( 2 * ( x * w + y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( w*y - x*z ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( 2 * ( z * w + x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//     }
//
//   }

  // debugger;

  // ex = atan2( ( x * y + z * w ), ( y * w - x * z ) );
  // ey = acos( w * w + x * x - y * y - z * z );
  // ez = atan2( ( x * y - z * w ), ( x * z + y * w ) );

  if( ox === 0 && oy === 1 && oz === 2 ) // xyz
  {
    ex = atan2( 2 * ( x * w - y * z ), ( w * w - x * x - y * y + z * z ) );
    ey = asin( 2 * ( x * z + y * w ) );
    ez = atan2( 2 * ( z * w - x * y ), ( w * w + x * x - y * y - z * z ) );
  }
  else if( ox === 0 && oy === 2 && oz === 1 ) // xzy
  {
    ex = atan2( 2 * ( x * w + y * z ), ( w * w - x * x + y * y - z * z ) );
    ey = asin( 2 * ( z * w - x * y ) );
    ez = atan2( 2 * ( x * z + y * w ), ( w * w + x * x - y * y - z * z ) );
  }
  else if( ox === 1 && oy === 0 && oz === 2 ) // yxz
  {
    ex = atan2( 2 * ( x * z + y * w ), ( w * w - x * x - y * y + z * z ) );
    ey = asin( 2 * ( x * w - y * z ) );
    ez = atan2( 2 * ( x * y + z * w ), ( w * w - x * x + y * y - z * z ) );
  }
  else if( ox === 1 && oy === 2 && oz === 0 ) // yzx
  {
    ex = atan2( 2 * ( y * w - x * z ), ( w * w + x * x - y * y - z * z ) );
    ey = asin( 2 * ( x * y + z * w ) );
    ez = atan2( 2 * ( x * w - z * y ), ( w * w - x * x + y * y - z * z ) );
  }
  else if( ox === 2 && oy === 0 && oz === 1 ) // zxy
  {
    ex = atan2( 2 * ( z * w - x * y ), ( w * w - x * x + y * y - z * z ) );
    ey = asin( 2 * ( x * w + y * z ) );
    ez = atan2( 2 * ( y * w - z * x ), ( w * w - x * x - y * y + z * z ) );
  }
  else if( ox === 2 && oy === 1 && oz === 0 ) // zyx
  {
    ex = atan2( 2 * ( x * y + z * w ), ( w * w + x * x - y * y - z * z ) );
    ey = asin( 2 * ( y * w - x * z ) );
    ez = atan2( 2 * ( x * w + z * y ), ( w * w - x * x - y * y + z * z ) );
  }
  else if( ox === 0 && oy === 1 && oz === 0 ) // xyx
  {
    ex = atan2( ( x * y + z * w ), ( y * w - x * z ) );
    ey = acos( w * w + x * x - y * y - z * z );
    ez = atan2( ( x * y - z * w ), ( x * z + y * w ) );
  }
  else if( ox === 0 && oy === 2 && oz === 0 ) // xzx
  {
    ex = atan2( ( x * z - y * w ), ( x * y + z * w ) );
    ey = acos( w * w + x * x - y * y - z * z );
    ez = atan2( ( x * z + y * w ), ( z * w - x * y ) );
  }
  else if( ox === 1 && oy === 0 && oz === 1 ) // yxy
  {
    ex = atan2( ( x * y - z * w ), ( x * w + y * z ) );
    ey = acos( w * w - x * x + y * y - z * z );
    ez = atan2( ( x * y + z * w ), ( x * w - y * z ) );
  }
  else if( ox === 1 && oy === 2 && oz === 1 ) // yzy
  {
    ex = atan2( ( x * w + y * z ), ( z * w - x * y ) );
    ey = acos( w * w - x * x + y * y - z * z );
    ez = atan2( ( y * z - x * w ), ( x * y + z * w ) );
  }
  else if( ox === 2 && oy === 0 && oz === 2 ) // zxz
  {
    ex = atan2( ( x * z + y * w ), ( x * w - y * z ) );
    ey = acos( w * w - x * x - y * y + z * z );
    ez = atan2( ( x * z - y * w ), ( x * w + y * z ) );
  }
  else if( ox === 2 && oy === 1 && oz === 2 ) // zyz
  {
    ex = atan2( ( y * z - x * w ), ( x * z + y * w ) );
    ey = acos( w * w - x * x - y * y + z * z );
    ez = atan2( ( x * w + y * z ), ( y * w - x * z ) );
  }
  else _.assert( 0,'unexpected euler order',dst );

  dstv.eSet( 0, ex );
  dstv.eSet( 1, ey );
  dstv.eSet( 2, ez );

  // xyz
  //
  //  atan2
  //  (
  //    2 * (q[1] * q[0] - q[2] * q[3]),
  //    (q[0] * q[0] - q[1] * q[1] - q[2] * q[2] + q[3] * q[3])
  //  );
  // theta = asin(2 * ( q[2] * q[0]) + q[1] * q[3] );
  // phi = atan2
  // (
  //    2 * (q[3] * q[0] - q[1] * q[2]),
  //    (q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3])
  // );

  // xzy
  // psi =
  //   atan2
  //   (
  //    2 * (q[1] * q[0] + q[2] * q[3]),
  //    (q[0] * q[0] - q[1] * q[1] + q[2] * q[2] - q[3] * q[3])
  //   );
  // theta = asin(2 * (q[3] * q[0] - q[1] * q[2]));
  // phi = atan2
  // (
  //   2 * (q[1] * q[3] + q[2] * q[0]),
  //   (q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3])
  // );

  // // case zyx:

  // (
  //  2*(q.y*q.z + q.w*q.x),
  //  q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
  //  -2*(q.x*q.z - q.w*q.y),
  //  2*(q.x*q.y + q.w*q.z),
  //  q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  // )

  // // case xyz:

  // (
  //   2*( - q.x*q.y + q.w*q.z),
  //   q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  //   2*( - q.y*q.z + q.w*q.x),
  //   q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
  //   +2*(q.x*q.z + q.w*q.y),
  // )
  //

  // // case xzy:

  // (
  //   +2*(q.x*q.z + q.w*q.y),
  //   q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  //   +2*(q.y*q.z + q.w*q.x),
  //   +q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
  //   -2*(q.x*q.y - q.w*q.z),
  // )

  // void threeaxisrot(double r11, double r12, double r21, double r31, double r32, double res[])
  // {
  //   res[0] = atan2( r31, r32 );
  //   res[1] = asin ( r21 );
  //   res[2] = atan2( r11, r12 );
  // }

  // void threeaxisrot(double r11, double r12, double r21, double r31, double r32, double res[])
  // {
  //   res[0] = atan2( r11, r12 );
  //   res[1] = asin ( r21 );
  //   res[2] = atan2( r31, r32 );
  // }

  // {
  //
  //   var test = ( x * z + y * w );
  //   if( test > +half )
  //   {
  //     xxx
  //     dstv.eSet( 0, +2 * Math.atan2( z,w ) );
  //     dstv.eSet( 1, +Math.PI / 2 );
  //     dstv.eSet( 2, 0 );
  //   }
  //   else if( test < -half )
  //   {
  //     yyy
  //     dstv.eSet( 0, -2 * Math.atan2( z,w ) );
  //     dstv.eSet( 1, -Math.PI / 2 );
  //     dstv.eSet( 2, 0 );
  //   }
  //   else
  //   {
  //     dstv.eSet( 0, atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
  //     dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
  //     dstv.eSet( 2, atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
  //   }
  //
  // }

  return dst;
}

// fromQuat.variates =
// {
//
//   xw0 : [ +1,-1 ],
//   yz0 : [ +1,-1 ],
//   xz1 : [ +1,-1 ],
//   yw1 : [ +1,-1 ],
//   zw2 : [ +1,-1 ],
//   xy2 : [ +1,-1 ],
//
//   sqw0 : [ +1,-1 ],
//   sqx0 : [ +1,-1 ],
//   sqy0 : [ +1,-1 ],
//   sqz0 : [ +1,-1 ],
//
//   sqw2 : [ +1,-1 ],
//   sqx2 : [ +1,-1 ],
//   sqy2 : [ +1,-1 ],
//   sqz2 : [ +1,-1 ],
//
// }

// void quaternion2Euler(const Quaternion& q, double res[], RotSeq rotSeq)
// {
//     switch(rotSeq){
//     case zyx:
//       threeaxisrot( 2*(q.x*q.y + q.w*q.z),
//                      q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                     -2*(q.x*q.z - q.w*q.y),
//                      2*(q.y*q.z + q.w*q.x),
//                      q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                      res);
//       break;
//
//     case zyz:
//       twoaxisrot( 2*(q.y*q.z - q.w*q.x),
//                    2*(q.x*q.z + q.w*q.y),
//                    q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                    2*(q.y*q.z + q.w*q.x),
//                   -2*(q.x*q.z - q.w*q.y),
//                   res);
//       break;
//
//     case zxy:
//       threeaxisrot( -2*(q.x*q.y - q.w*q.z),
//                       q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                       2*(q.y*q.z + q.w*q.x),
//                      -2*(q.x*q.z - q.w*q.y),
//                       q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                       res);
//       break;
//
//     case zxz:
//       twoaxisrot( 2*(q.x*q.z + q.w*q.y),
//                   -2*(q.y*q.z - q.w*q.x),
//                    q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                    2*(q.x*q.z - q.w*q.y),
//                    2*(q.y*q.z + q.w*q.x),
//                    res);
//       break;
//
//     case yxz:
//       threeaxisrot( 2*(q.x*q.z + q.w*q.y),
//                      q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                     -2*(q.y*q.z - q.w*q.x),
//                      2*(q.x*q.y + q.w*q.z),
//                      q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                      res);
//       break;
//
//     case yxy:
//       twoaxisrot( 2*(q.x*q.y - q.w*q.z),
//                    2*(q.y*q.z + q.w*q.x),
//                    q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                    2*(q.x*q.y + q.w*q.z),
//                   -2*(q.y*q.z - q.w*q.x),
//                   res);
//       break;
//
//     case yzx:
//       threeaxisrot( -2*(q.x*q.z - q.w*q.y),
//                       q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                       2*(q.x*q.y + q.w*q.z),
//                      -2*(q.y*q.z - q.w*q.x),
//                       q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                       res);
//       break;
//
//     case yzy:
//       twoaxisrot( 2*(q.y*q.z + q.w*q.x),
//                   -2*(q.x*q.y - q.w*q.z),
//                    q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                    2*(q.y*q.z - q.w*q.x),
//                    2*(q.x*q.y + q.w*q.z),
//                    res);
//       break;
//
//     case xyz:
//       threeaxisrot( -2*(q.y*q.z - q.w*q.x),
//                     q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                     2*(q.x*q.z + q.w*q.y),
//                    -2*(q.x*q.y - q.w*q.z),
//                     q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                     res);
//       break;
//
//     case xyx:
//       twoaxisrot( 2*(q.x*q.y + q.w*q.z),
//                   -2*(q.x*q.z - q.w*q.y),
//                    q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                    2*(q.x*q.y - q.w*q.z),
//                    2*(q.x*q.z + q.w*q.y),
//                    res);
//       break;
//
//     case xzy:
//       threeaxisrot( 2*(q.y*q.z + q.w*q.x),
//                      q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                     -2*(q.x*q.y - q.w*q.z),
//                      2*(q.x*q.z + q.w*q.y),
//                      q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                      res);
//       break;
//
//     case xzx:
//       twoaxisrot( 2*(q.x*q.z - q.w*q.y),
//                    2*(q.x*q.y + q.w*q.z),
//                    q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                    2*(q.x*q.z + q.w*q.y),
//                   -2*(q.x*q.y - q.w*q.z),
//                   res);
//       break;
//     default:
//       std::cout << "Unknown rotation sequence" << std::endl;
//       break;
//    }
// }

//

function fromMatrix( euler,mat )
{
  var /*eps*/accuracy = 1e-7;
  var one = 1-/*eps*/accuracy;

  var euler = _.euler.from( euler );
  var eulerv = _.vector.from( euler );

  var s00 = mat.atomGet([ 0,0 ]), s10 = mat.atomGet([ 1,0 ]), s20 = mat.atomGet([ 2,0 ]);
  var s01 = mat.atomGet([ 0,1 ]), s11 = mat.atomGet([ 1,1 ]), s21 = mat.atomGet([ 2,1 ]);
  var s02 = mat.atomGet([ 0,2 ]), s12 = mat.atomGet([ 1,2 ]), s22 = mat.atomGet([ 2,2 ]);

  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

// m1
// -0.875, 0.250, 0.415,
// 0.250, -0.500, 0.829,
// 0.415, 0.829, 0.375,
// m2
// -0.875, -0.476, 0.086,
// 0.250, -0.292, 0.923,
// -0.415, 0.829, 0.375,

  // debugger; xxx

  eulerv.eSet( 1,asin( clamp( s02, - 1, + 1 ) ) );

  if( abs( /*eps*/accuracy ) < one )
  {
    eulerv.eSet( 0,atan2( - s12, s22 ) );
    eulerv.eSet( 2,atan2( - s01, s00 ) );
    // eulerv.eSet( 0,atan2( s12, s22 ) );
    // eulerv.eSet( 2,atan2( s01, s00 ) );
  }
  else
  {
    bbb
    eulerv.eSet( 0,atan2( s21, s11 ) );
    eulerv.eSet( 2,0 );
  }

// rz*ry*rx
//
// [ cy*cz, cz*sx*sy - cx*sz, sx*sz + cx*cz*sy]
// [ cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx]
// [ -sy,   cy*sx,      cx*cy]
//
// ry*rz*rx
//
// [  cy*cz, sx*sy - cx*cy*sz, cx*sy + cy*sx*sz]
// [         sz,      cx*cz,     -cz*sx]
// [ -cz*sy, cy*sx + cx*sy*sz, cx*cy - sx*sy*sz]
//
// rz*rx*ry
//
// [ cy*cz - sx*sy*sz, -cx*sz, cz*sy + cy*sx*sz]
// [ cy*sz + cz*sx*sy,  cx*cz, sy*sz - cy*cz*sx]
// [     -cx*sy,         sx,      cx*cy]
//
// rx*rz*ry
//
// [      cy*cz,       -sz,      cz*sy]
// [ sx*sy + cx*cy*sz, cx*cz, cx*sy*sz - cy*sx]
// [ cy*sx*sz - cx*sy, cz*sx, cx*cy + sx*sy*sz]
//
// ry*rx*rz
//
// [ cy*cz + sx*sy*sz, cz*sx*sy - cy*sz, cx*sy]
// [      cx*sz,      cx*cz,       -sx]
// [ cy*sx*sz - cz*sy, sy*sz + cy*cz*sx, cx*cy]
//
// rx*ry*rz
//
// [      cy*cz,     -cy*sz,         sy]
// [ cx*sz + cz*sx*sy, cx*cz - sx*sy*sz, -cy*sx]
// [ sx*sz - cx*cz*sy, cz*sx + cx*sy*sz,  cx*cy]
//
// rxz*ry*rx
//
// [  cy,        sx*sy,          cx*sy]
// [  sy*sz, cx*cz - cy*sx*sz, - cz*sx - cx*cy*sz]
// [ -cz*sy, cx*sz + cy*cz*sx,   cx*cy*cz - sx*sz]

  // var sx = sin( x );
  // var sy = sin( y );
  // var sz = sin( z );
  //
  // var cx = cos( x );
  // var cy = cos( y );
  // var cz = cos( z );

  return euler;
}

//

function toMatrix( euler,mat,premutating )
{
  // var /*eps*/accuracy = 1e-9;
  // var half = 0.5-/*eps*/accuracy;

  if( mat === null || mat === undefined )
  mat = _.Space.make([ 3,3 ]);

  var euler = _.euler.from( euler );
  var eulerv = _.vector.from( euler );

  if( premutating === undefined )
  premutating = true;

  _.assert( _.euler.is( euler ) );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );

  // debugger;

  var ox = eulerv.eGet( 3 );
  var oy = eulerv.eGet( 4 );
  var oz = eulerv.eGet( 5 );

  // var ox = 0;
  // var oy = 1;
  // var oz = 2;

  var x = eulerv.eGet( ox );
  var y = eulerv.eGet( oy );
  var z = eulerv.eGet( oz );

  var sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  sign = sign ? -1 : + 1;
  // console.log( 'sign',sign );

  // var sx = ( ox === 0 && sign === 1 ) ? sin( x ) : cos( x );
  var sx = sin( x );
  var sy = sin( y );
  var sz = sin( z );

  // var cx = ( ox === 0 && sign === 1 ) ? cos( x ) : sin( x );
  var cx = cos( x );
  var cy = cos( y );
  var cz = cos( z );

  var cx_sy = cx*sy;
  var sx_sy = sx*sy;
  var cx_sz = cx*sz;
  var sx_sz = sx*sz;
  var cx_cy = cx*cy;
  var sx_cy = sx*cy;
  var cx_cz = cx*cz;
  var sx_cz = sx*cz;
  var cy_sz = cy*sz;
  var sy_sz = sy*sz;
  var cy_cz = cy*cz;
  var sy_cz = sy*cz;

  var m00,m01,m02;
  var m10,m11,m12;
  var m20,m21,m22;

  if( premutating )
  {

    mat.atomSet( [ 0,0 ],+cy_cz );
    mat.atomSet( [ 1,0 ],+cy_sz*sign );
    mat.atomSet( [ 2,0 ],-sy*sign );

    mat.atomSet( [ 0,1 ],+( +sx_sy*cz - cx_sz*sign ) );
    mat.atomSet( [ 1,1 ],+cx_cz + sx_sy*sz*sign );
    mat.atomSet( [ 2,1 ],+sx_cy*sign );

    mat.atomSet( [ 0,2 ],+sx_sz + cx_sy*cz*sign );
    mat.atomSet( [ 1,2 ],+( +cx_sy*sz - sx_cz*sign ) );
    mat.atomSet( [ 2,2 ],+cx_cy );

  }
  else
  {

    mat.atomSet( [ ox,ox ],+cy_cz );
    mat.atomSet( [ oy,ox ],-cy_sz*sign );
    mat.atomSet( [ oz,ox ],sy*sign );

    mat.atomSet( [ ox,oy ],+( +sx_sy*cz + cx_sz*sign ) );
    mat.atomSet( [ oy,oy ],+cx_cz - sx_sy*sz*sign );
    mat.atomSet( [ oz,oy ],-sx_cy*sign );

    mat.atomSet( [ ox,oz ],+sx_sz - cx_sy*cz*sign );
    mat.atomSet( [ oy,oz ],+( +cx_sy*sz + sx_cz*sign ) );
    mat.atomSet( [ oz,oz ],+cx_cy );

    // /* */
    //
    // mat.atomSet( [ 0,0 ],+cy_cz );
    // mat.atomSet( [ 1,0 ],-cy_sz*sign );
    // mat.atomSet( [ 2,0 ],sy*sign );
    //
    // mat.atomSet( [ 0,1 ],+( +sx_sy*cz + cx_sz*sign ) );
    // mat.atomSet( [ 1,1 ],+cx_cz - sx_sy*sz*sign );
    // mat.atomSet( [ 2,1 ],-sx_cy*sign );
    //
    // mat.atomSet( [ 0,2 ],+sx_sz - cx_sy*cz*sign );
    // mat.atomSet( [ 1,2 ],+( +cx_sy*sz + sx_cz*sign ) );
    // mat.atomSet( [ 2,2 ],+cx_cy );

  }

  mat.atomSet( [ 0,0 ],+cy_cz );
  mat.atomSet( [ 1,0 ],-cy_sz*sign );
  mat.atomSet( [ 2,0 ],sy*sign );

  mat.atomSet( [ 0,1 ],+( +sx_sy*cz + cx_sz*sign ) );
  mat.atomSet( [ 1,1 ],+cx_cz - sx_sy*sz*sign );
  mat.atomSet( [ 2,1 ],-sx_cy*sign );

  mat.atomSet( [ 0,2 ],+sx_sz - cx_sy*cz*sign );
  mat.atomSet( [ 1,2 ],+( +cx_sy*sz + sx_cz*sign ) );
  mat.atomSet( [ 2,2 ],+cx_cy );

  // debugger;

// rx*ry*rz
//
// | cx*cy    cx*sy*sz - sx*cz    cx*sy*cz + sx*sz |
// | sx*cy    sx*sy*sz + cx*cz    sx*sy*cz - cx*sz |
// | -sy                 cy*sz               cy*cz |
//

  // if( ox === 0 && oy === 1 && oz === 2 ) /* xyz */
  // {
  //
  //   var m00 = +cy_cz;
  //   var m10 = +cy_sz;
  //   var m20 = -sy;
  //
  //   var m01 = +sx_sy*cz - cx_sz;
  //   var m11 = +cx_cz + sx_sy*sz;
  //   var m21 = +sx_cy;
  //
  //   var m02 = +sx_sz + cx_sy*cz;
  //   var m12 = +cx_sy*sz - sx_cz;
  //   var m22 = +cx_cy;
  //
  // }
  // else if( ox === 0 && oy === 2 && oz === 1 ) /* xzy */
  // {
  //
    // var m00 = +cy_cz;
    // var m10 = +sz;
    // var m20 = -sy_cz;
    //
    // var m01 = +sx_sy - cx_cy*sz;
    // var m11 = +cx_cz;
    // var m21 = +sx_cy + cx_sy*sz;
    //
    // var m02 = +cx_sy + sx_cy*sz;
    // var m12 = -sx_cz;
    // var m22 = +cx_cy - sx_sy*sz;
  //
  // }
  // else _.assert( 0 );
  //
  // /* */
  //
  // mat.atomSet( [ 0,0 ],m00 );
  // mat.atomSet( [ 1,0 ],m10 );
  // mat.atomSet( [ 2,0 ],m20 );
  //
  // mat.atomSet( [ 0,1 ],m01 );
  // mat.atomSet( [ 1,1 ],m11 );
  // mat.atomSet( [ 2,1 ],m21 );
  //
  // mat.atomSet( [ 0,2 ],m02 );
  // mat.atomSet( [ 1,2 ],m12 );
  // mat.atomSet( [ 2,2 ],m22 );

// rz*ry*rx
//
// [ cy*cz, cz*sx*sy - cx*sz, sx*sz + cx*cz*sy]
// [ cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx]
// [ -sy,   cy*sx,      cx*cy]
//
// ry*rz*rx
//
// [  cy*cz, sx*sy - cx*cy*sz, cx*sy + cy*sx*sz]
// [         sz,      cx*cz,     -cz*sx]
// [ -cz*sy, cy*sx + cx*sy*sz, cx*cy - sx*sy*sz]
//
// rz*rx*ry
//
// [ cy*cz - sx*sy*sz, -cx*sz, cz*sy + cy*sx*sz]
// [ cy*sz + cz*sx*sy,  cx*cz, sy*sz - cy*cz*sx]
// [     -cx*sy,         sx,      cx*cy]
//
// rx*rz*ry
//
// [      cy*cz,       -sz,      cz*sy]
// [ sx*sy + cx*cy*sz, cx*cz, cx*sy*sz - cy*sx]
// [ cy*sx*sz - cx*sy, cz*sx, cx*cy + sx*sy*sz]
//
// ry*rx*rz
//
// [ cy*cz + sx*sy*sz, cz*sx*sy - cy*sz, cx*sy]
// [      cx*sz,      cx*cz,       -sx]
// [ cy*sx*sz - cz*sy, sy*sz + cy*cz*sx, cx*cy]
//
// rx*ry*rz
//
// [      cy*cz,     -cy*sz,         sy]
// [ cx*sz + cz*sx*sy, cx*cz - sx*sy*sz, -cy*sx]
// [ sx*sz - cx*cz*sy, cz*sx + cx*sy*sz,  cx*cy]
//
// | cx*cy    cx*sy*sz - sx*cz    cx*sy*cz + sx*sz |
// | sx*cy    sx*sy*sz + cx*cz    sx*sy*cz - cx*sz |
// | -sy                  cy*sz              cy*cz |
//
// [ cy*cx, cx*sz*sy - cz*sx, sz*sx + cz*cx*sy ]
// [ cy*sx, cz*cx + sz*sy*sx, cz*sy*sx - cx*sz ]
// [ -sy,   cy*sz,            cz*cy ]

// rxz*ry*rx
//
// [  cy,        sx*sy,          cx*sy]
// [  sy*sz, cx*cz - cy*sx*sz, - cz*sx - cx*cy*sz]
// [ -cz*sy, cx*sz + cy*cz*sx,   cx*cy*cz - sx*sz]

  return mat;
}

// --
// var
// --

var Order =
{

  'xyz' : [ 0,1,2 ],
  'xzy' : [ 0,2,1 ],
  'yxz' : [ 1,0,2 ],
  'yzx' : [ 1,2,0 ],
  'zxy' : [ 2,0,1 ],
  'zyx' : [ 2,1,0 ],

}


/**
  * Create a set of euler angles from a quaternion. Returns the created euler angles.
  * Quaternion stay untouched, dst contains the euler angle representation.
  *
  * @param { Array } dstEuler - Destination representation of Euler angles with source euler angles code.
  * @param { Array } srcQuat - Source quaternion.
  *
  * @example
  * // returns [ 1, 0, 0, 0, 1, 2 ];
  * _.fromQuat2( [ 0.49794255, 0, 0, 0.8775826 ], [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0, 1, 0, 2, 1, 0 ];
  * _.fromQuat2( [ 0, 0.4794255, 0, 0.8775826 ], [ 0, 0, 0, 2, 1, 0 ] );
  *
  * @returns { Quat } Returns the corresponding quaternion.
  * @function fromQuat2
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( srcQuat ) is not quat.
  * @throws { Error } An Error if( dstEuler ) is not euler ( or null/undefined ).
  * @memberof wTools.euler
  */

function fromQuat2( dstEuler, srcQuat )
{

  _.assert( arguments.length === 2 );
  _.assert( dstEuler === undefined || dstEuler === null || _.euler.is( dstEuler ) );

  if( dstEuler === undefined || dstEuler === null )
  dstEuler = _.euler.makeZero();

  var dstEuler = _.euler.from( dstEuler );
  var dstEulerVector = _.euler._from( dstEuler );
  var srcQuatVector = _.quat._from( srcQuat );
  var accuracy =  _.accuracy;
  var accuracySqr = _.accuracySqr;

  var x = srcQuatVector.eGet( 0 ); var x2 = x*x;
  var y = srcQuatVector.eGet( 1 ); var y2 = y*y;
  var z = srcQuatVector.eGet( 2 ); var z2 = z*z;
  var w = srcQuatVector.eGet( 3 ); var w2 = w*w;

  var xy2 = 2*x*y; var xz2 = 2*x*z; var xw2 = 2*x*w;
  var yz2 = 2*y*z; var yw2 = 2*y*w; var zw2 = 2*z*w;

  var ox = dstEulerVector.eGet( 3 );
  var oy = dstEulerVector.eGet( 4 );
  var oz = dstEulerVector.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    var lim = xz2 + yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( -( xy2 - zw2 ) , w2  + x2 - z2 - y2 ) );
      dstEulerVector.eSet( 1, asin( lim ) );
      dstEulerVector.eSet( 0, atan2( - ( yz2 - xw2 ) , z2 - y2 - x2 + w2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerVector.eSet( 0, - atan2( ( xy2 + zw2 ), ( xz2 - yw2 ) ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerVector.eSet( 0, - atan2( -1*( xy2 + zw2 ), -1*( xz2 - yw2 ) ) );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    var lim = xy2 - zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( xz2 + yw2 , x2 + w2 - z2 - y2 ) );
      dstEulerVector.eSet( 1, - asin( lim ) );
      dstEulerVector.eSet( 0, atan2( yz2 + xw2 , y2 - z2 + w2 - x2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerVector.eSet( 0, atan2( (xz2 - yw2 ), ( xy2 + zw2 ) ) );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerVector.eSet( 0, atan2( -1*( yz2 - xw2 ), 1-2*( x2 + y2 ) ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    var lim = yz2 - xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( xy2 + zw2 , y2 - z2 + w2 - x2 ) );
      dstEulerVector.eSet( 1, - asin( lim ) );
      dstEulerVector.eSet( 0, atan2( xz2 + yw2 , z2 - y2 - x2 + w2 ) );
    }
    else if( lim <= -1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xy2 - zw2 ), ( yz2 + xw2 ) ) );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerVector.eSet( 0, atan2( -1*( xz2 - yw2 ), 1-2*( y2 + z2 ) ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    var lim = xy2 + zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( - yz2 + xw2 , y2 - z2 + w2 - x2 ) );
      dstEulerVector.eSet( 1, asin( lim ) );
      dstEulerVector.eSet( 0, atan2( - xz2 + yw2 , x2 + w2 - z2 - y2  ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerVector.eSet( 0, atan2( (xz2 + yw2 ), ( xy2 - zw2 ) ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( ( xy2 + zw2 ) >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerVector.eSet( 0, atan2( xz2 + yw2, 1-2*( x2 + y2 ) ) );
      dstEulerVector.eSet( 1, + pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    var lim = yz2 + xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( - xz2 + yw2 , z2 - y2 - x2 + w2  ) );
      dstEulerVector.eSet( 1, asin( lim ) );
      dstEulerVector.eSet( 0, atan2( - xy2 + zw2 , y2 - z2 + w2 - x2  ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xy2 + zw2 ), ( yz2 - xw2 ) ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerVector.eSet( 0, atan2( xy2 + zw2, 1-2*( y2 + z2 ) ) );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    var lim = xz2 - yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( yz2 + xw2 , z2 - y2 - x2 + w2 ) );
      dstEulerVector.eSet( 1, asin( - lim ) );
      dstEulerVector.eSet( 0, atan2( xy2 + zw2 , x2 + w2 - y2 - z2 ) );
    }
    else if( lim <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerVector.eSet( 0, - atan2( ( xy2 - zw2 ), ( xz2 + yw2 ) ) );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracy*accuracy)
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerVector.eSet( 0, atan2( -1*( xy2 - zw2 ), -1*( xz2 + yw2 ) ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    var lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( xy2 - zw2 , xz2 + yw2 ) );
      dstEulerVector.eSet( 1, acos( lim ) );
      dstEulerVector.eSet( 0, atan2( xy2 + zw2 , -xz2 + yw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( yz2 - xw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( yz2 + xw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    var lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr)
    {
      dstEulerVector.eSet( 2, atan2( xz2 + yw2 , -xy2 + zw2 ) );
      dstEulerVector.eSet( 1, acos( lim ) );
      dstEulerVector.eSet( 0, atan2( xz2 - yw2 , xy2 + zw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerVector.eSet( 0, - atan2( ( yz2 + xw2 ), 1 - 2*( x2 + y2 ) ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( yz2 + xw2 ), 1 - 2*( x2 + y2 ) ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    var lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( xy2 + zw2 , -yz2 + xw2 ) );
      dstEulerVector.eSet( 1, acos( lim ) );
      dstEulerVector.eSet( 0, atan2( xy2 - zw2 , yz2 + xw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerVector.eSet( 0, - atan2( ( xz2 - yw2 ), 1 - 2*( z2 + y2 ) ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xz2 + yw2 ), 1 - 2*( z2 + y2 ) ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    var lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( yz2 - xw2 , xy2 + zw2 ) );
      dstEulerVector.eSet( 1, acos( lim ) );
      dstEulerVector.eSet( 0, atan2( yz2 + xw2 , -xy2 + zw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xz2 - yw2 ), 1 - 2*( y2 + x2 ) ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xz2 + yw2 ), 1 - 2*( y2 + x2 ) ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    var lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( ( xz2 - yw2 ), ( yz2 + xw2 ) ) );
      dstEulerVector.eSet( 1, acos( lim ) );
      dstEulerVector.eSet( 0, atan2( ( xz2 + yw2 ), - ( yz2 - xw2 ) ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xy2 - zw2 ), 1 - 2*( y2 + z2 ) ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerVector.eSet( 0, - atan2( ( xy2 - zw2 ), 1 - 2*( y2 + z2 ) ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    var lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerVector.eSet( 2, atan2( ( yz2 + xw2 ), ( - xz2 + yw2 ) ) );
      dstEulerVector.eSet( 1, acos( lim ) );
      dstEulerVector.eSet( 0, atan2( ( yz2 - xw2 ), ( xz2 + yw2 ) ) );
    }
    else if( lim <= -1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerVector.eSet( 0, atan2( -( xy2 - zw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerVector.eSet( 0, atan2( ( xy2 + zw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  /* */

  return dstEuler;
}

//

/**
  * Create the quaternion from a set of euler angles. Returns the created quaternion.
  * Euler angles stay untouched.
  *
  * @param { Array } srcEuler - Source representation of Euler angles.
  * @param { Array } dstQuat - Destination quaternion array.
  *
  * @example
  * // returns [ 0.49794255, 0, 0, 0.8775826 ];
  * _.toQuat2( [ 1, 0, 0, 0, 1, 2 ], null );
  *
  * @example
  * // returns [ 0, 0.4794255, 0, 0.8775826 ];
  * _.toQuat2( [ 0, 1, 0, 2, 1, 0 ], null );
  *
  * @returns { Quat } Returns the corresponding quaternion.
  * @function toQuat2
  * @throws { Error } An Error if( arguments.length ) is different than one.
  * @throws { Error } An Error if( srcEuler ) is not euler.
  * @memberof wTools.euler
  */

function toQuat2( srcEuler, dstQuat )
{

  _.assert( arguments.length === 2 );
  _.assert( _.euler.is( srcEuler ) );
  _.assert( dstQuat === undefined || dstQuat === null || _.quat.is( dstQuat ) );

  if( dstQuat === undefined || dstQuat === null )
  dstQuat = _.quat.makeUnit();

  var srcEuler = _.euler.from( srcEuler );
  var srcEulerVector = _.euler._from( srcEuler );
  var dstQuat = _.quat.from( dstQuat );
  var dstQuatVector = _.quat._from( dstQuat );

  var e0 = srcEulerVector.eGet( 0 );
  var e1 = srcEulerVector.eGet( 1 );
  var e2 = srcEulerVector.eGet( 2 );
  var ox = srcEulerVector.eGet( 3 );
  var oy = srcEulerVector.eGet( 4 );
  var oz = srcEulerVector.eGet( 5 );

  var s0 = sin( e0/2 ); var c0 = cos( e0/2 );
  var s1 = sin( e1/2 ); var c1 = cos( e1/2 );
  var s2 = sin( e2/2 ); var c2 = cos( e2/2 );

  /* qqq : not optimal */

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    dstQuatVector.eSet( 0, s0*c1*c2 + c0*s1*s2 );
    dstQuatVector.eSet( 1, c0*s1*c2 - s0*c1*s2 );
    dstQuatVector.eSet( 2, c0*c1*s2 + s0*s1*c2 );
    dstQuatVector.eSet( 3, c0*c1*c2 - s0*s1*s2 );
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    dstQuatVector.eSet( 0, s0*c1*c2 - c0*s1*s2 );
    dstQuatVector.eSet( 1, c0*c1*s2 - s0*s1*c2 );
    dstQuatVector.eSet( 2, c0*s1*c2 + s0*c1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 + s0*s1*s2 );
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    var sum = ( e0 + e2 )/2;
    var dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, sin( sum )*c1 );
    dstQuatVector.eSet( 1, cos( dif )*s1 );
    dstQuatVector.eSet( 2, sin( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    var sum = ( e0 + e2 )/2;
    var dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, sin( sum )*c1 );
    dstQuatVector.eSet( 1, - sin( dif )*s1 );
    dstQuatVector.eSet( 2, cos( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    dstQuatVector.eSet( 0, c0*s1*c2 + s0*c1*s2 );
    dstQuatVector.eSet( 1, s0*c1*c2 - c0*s1*s2 );
    dstQuatVector.eSet( 2, c0*c1*s2 - s0*s1*c2 );
    dstQuatVector.eSet( 3, c0*c1*c2 + s0*s1*s2 );
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    dstQuatVector.eSet( 0, c0*c1*s2 + s0*s1*c2 );
    dstQuatVector.eSet( 1, s0*c1*c2 + c0*s1*s2 );
    dstQuatVector.eSet( 2, c0*s1*c2 - s0*c1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 - s0*s1*s2 );
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    var sum = ( e0 + e2 )/2;
    var dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, cos( dif )*s1 );
    dstQuatVector.eSet( 1, sin( sum )*c1 );
    dstQuatVector.eSet( 2, - sin( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    var sum = ( e0 + e2 )/2;
    var dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, sin( dif )*s1 );
    dstQuatVector.eSet( 1, sin( sum )*c1 );
    dstQuatVector.eSet( 2, cos( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    dstQuatVector.eSet( 0, c0*c1*s2 - s0*s1*c2 );
    dstQuatVector.eSet( 1, c0*s1*c2 + s0*c1*s2 );
    dstQuatVector.eSet( 2, s0*c1*c2 - c0*s1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 + s0*s1*s2 );
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    dstQuatVector.eSet( 0, c0*s1*c2 - s0*c1*s2 );
    dstQuatVector.eSet( 1, c0*c1*s2 + s0*s1*c2 );
    dstQuatVector.eSet( 2, s0*c1*c2 + c0*s1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 - s0*s1*s2 );
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    var sum = ( e0 + e2 )/2;
    var dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, cos( dif )*s1 );
    dstQuatVector.eSet( 1, sin( dif )*s1 );
    dstQuatVector.eSet( 2, sin( sum )*c1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    var sum = ( e0 + e2 )/2;
    var dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, - sin( dif )*s1 );
    dstQuatVector.eSet( 1, cos( dif )*s1 );
    dstQuatVector.eSet( 2, sin( sum )*c1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }
  else _.assert( 0 );

  return dstQuat;
}

//

/**
  * Create the euler angle from a rotation matrix. Returns the created euler angle.
  * Rotation matrix stays untouched.
  *
  * @param { Array } dstEuler - Destination array with euler angle source code.
  * @param { Space } srcMatrix - Source rotation matrix.
  *
  * @example
  * // returns [ 0.5, 0.5, 0.5, 0, 1, 2 ]
  *  srcMatrix  = _.Space.make( [ 3, 3 ] ).copy(
  *            [ 0.7701, -0.4207, 0.4794,
  *             0.6224, 0.6599, - 0.4207,
  *           - 0.1393, 0.6224, 0.7701 ] );
  * _.fromMatrix2( srcMatrix, [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @returns { Array } Returns the corresponding euler angles.
  * @function fromMatrix2
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( dstEuler ) is not euler.
  * @throws { Error } An Error if( srcMatrix ) is not matrix.
  * @memberof wTools.euler
  */

function fromMatrix2( dstEuler, srcMatrix )
{
  _.assert( arguments.length === 2 );
  _.assert( dstEuler === undefined || dstEuler === null || _.euler.is( dstEuler ) );

  if( dstEuler === undefined || dstEuler === null )
  dstEuler = _.euler.makeZero();

  var dstEuler = _.euler.from( dstEuler );
  var dstEulerVector = _.vector.from( dstEuler );

  _.assert( _.Space.is( srcMatrix ) );
  _.assert( srcMatrix.dims[ 0 ] >= 3 );
  _.assert( srcMatrix.dims[ 1 ] >= 3 );

  var ox = dstEulerVector.eGet( 3 );
  var oy = dstEulerVector.eGet( 4 );
  var oz = dstEulerVector.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    var m02 = srcMatrix.atomGet( [ 0, 2 ] );
    if( - 1 < m02 && m02 < 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerVector.eSet( 0, atan2( - m12, m22 ) );
      dstEulerVector.eSet( 1, atan2( m02, sqrt( 1 - m02*m02 ) ) );
      dstEulerVector.eSet( 2, atan2( - m01, m00 ) );
    }
    else if( m02 <= - 1 )
    {
      var m10 = srcMatrix.atomGet( [ 1, 0 ] ); var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 0, - atan2( m10, m11 ) );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m02 >= 1 )
    {
      var m10 = srcMatrix.atomGet( [ 1, 0 ] ); var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 0, atan2( m10, m11 ) );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    var m01 = srcMatrix.atomGet( [ 0,1 ] );
    if( - 1 < m01 && m01 < 1 )
    {
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 0, atan2( m21, m11 ) );
      dstEulerVector.eSet( 2, atan2( m02, m00 ) );
      dstEulerVector.eSet( 1, asin( - m01) );
    }
    else if( m01 >= 1 )
    {
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 0, atan2( - m20, m22 ) );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 1, - pi/2 );
    }
    else if( m01 <= - 1 )
    {
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 0, - atan2( - m20, m22 ) );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 1, pi/2 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    var m12 = srcMatrix.atomGet( [ 1, 2 ] );
    if( - 1 < m12 && m12 < 1 )
    {
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 1, asin( -m12 ) );
      dstEulerVector.eSet( 0, atan2( m02, m22 ) );
      dstEulerVector.eSet( 2, atan2( m10, m11 ) );
    }
    else if( m12 >= 1 )
    {
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 0, atan2( - m01, m00 ) );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m12 <= - 1 )
    {
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerVector.eSet( 1, pi/2);
      dstEulerVector.eSet( 0, - atan2( - m01, m00 )  );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    var m10 = srcMatrix.atomGet( [ 1, 0 ] );
    if( - 1 < m10 && m10 < 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 2, atan2( - m12, m11 ) );
      dstEulerVector.eSet( 0, atan2( - m20, m00 ) );
      dstEulerVector.eSet( 1, asin( m10 ) );
    }
    else if( m10 <= - 1 )
    {
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 0, - atan2( m21, m22 ) );
      dstEulerVector.eSet( 1, - pi/2 );
    }
    else if( m10 >= 1 )
    {
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 0, atan2( m21, m22 )  );
      dstEulerVector.eSet( 1, pi/2 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    var m21 = srcMatrix.atomGet( [ 2, 1 ] );
    if( - 1 < m21 && m21 < 1 )
    {
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 1, asin( m21 ) );
      dstEulerVector.eSet( 2, atan2( - m20, m22 ) );
      dstEulerVector.eSet( 0, atan2( - m01, m11 ) );
    }
    else if( m21 <= - 1 )
    {
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 0, - atan2( m02, m00 ) );
    }
    else if( m21 >= 1 )
    {
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 0, atan2( m02, m00 ) );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    var m20 = srcMatrix.atomGet( [ 2, 0 ] );
    if( - 1 < m20 && m20 < 1 )
    {
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 2, atan2( m21, m22 ) );
      dstEulerVector.eSet( 1, asin( - m20 ) );
      dstEulerVector.eSet( 0, atan2( m10, m00 ) );
    }
    else if( m20 <= - 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 1, pi/2 );
      dstEulerVector.eSet( 0, - atan2( - m12, m11 ) );
    }
    else if( m20 >= 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 2, 0 );
      dstEulerVector.eSet( 1, - pi/2 );
      dstEulerVector.eSet( 0, atan2( - m12, m11 ) );
    }
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    var m00 = srcMatrix.atomGet( [ 0, 0 ] );
    if( - 1 < m00 && m00 < 1 )
    {
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      dstEulerVector.eSet( 0, atan2( m10, - m20 ) );
      dstEulerVector.eSet( 1, acos( m00 ) );
      dstEulerVector.eSet( 2, atan2( m01, m02 ) );
    }
    else if( m00 <= - 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 0, - atan2( - m12, m11 ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m00 >= 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 0, atan2( - m12, m11 ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    var m00 = srcMatrix.atomGet( [ 0, 0 ] );
    if( - 1 < m00 && m00 < 1 )
    {
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerVector.eSet( 0, atan2( m20, m10 ) );
      dstEulerVector.eSet( 1, acos( m00 ) );
      dstEulerVector.eSet( 2, atan2( m02, - m01 ) );
    }
    else if( m00 <= - 1 )
    {
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 0, - atan2( m21, m22 ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m00 >= 1 )
    {
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 0, atan2( m21, m22 ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    var m11 = srcMatrix.atomGet( [ 1, 1 ] );
    if( - 1 < m11 && m11 < 1 )
    {
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      dstEulerVector.eSet( 0, atan2( m01, m21 ) );
      dstEulerVector.eSet( 1, acos( m11 ) );
      dstEulerVector.eSet( 2, atan2( m10, - m12 ) );
    }
    else if( m11 <= - 1 )
    {
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 0, - atan2( m02, m00 ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m11 >= 1 )
    {
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 0, atan2( m02, m00 ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    var m11 = srcMatrix.atomGet( [ 1, 1 ] );
    if( - 1 < m11 && m11 < 1 )
    {
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      dstEulerVector.eSet( 0, atan2( m21, - m01 ) );
      dstEulerVector.eSet( 1, acos( m11 ) );
      dstEulerVector.eSet( 2, atan2( m12, m10 ) );
    }
    else if( m11 <= - 1 )
    {
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 0, atan2( m20, m22 ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m11 >= 1 )
    {
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerVector.eSet( 0, atan2( - m20, m22 ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    var m22 = srcMatrix.atomGet( [ 2, 2 ] );
    if( - 1 < m22 && m22 < 1 )
    {
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      dstEulerVector.eSet( 0, atan2( m02, - m12 ) );
      dstEulerVector.eSet( 1, acos( m22 ) );
      dstEulerVector.eSet( 2, atan2( m20, m21 ) );
    }
    else if( m22 <= - 1 )
    {
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 0, atan2( m01, m00 ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m22 >= 1 )
    {
      var m01 = srcMatrix.atomGet( [ 0, 1 ] );
      var m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerVector.eSet( 0, - atan2( m01, m00 ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    var m22 = srcMatrix.atomGet( [ 2, 2 ] );
    if( - 1 < m22 && m22 < 1 )
    {
      var m12 = srcMatrix.atomGet( [ 1, 2 ] );
      var m02 = srcMatrix.atomGet( [ 0, 2 ] );
      var m21 = srcMatrix.atomGet( [ 2, 1 ] );
      var m20 = srcMatrix.atomGet( [ 2, 0 ] );
      dstEulerVector.eSet( 0, atan2( m12, m02 ) );
      dstEulerVector.eSet( 1, acos( m22 ) );
      dstEulerVector.eSet( 2, atan2( m21, - m20 ) );
    }
    else if( m22 <= - 1 )
    {
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 0, - atan2( m10, m11 ) );
      dstEulerVector.eSet( 1, pi );
      dstEulerVector.eSet( 2, 0 );
    }
    else if( m22 >= 1 )
    {
      var m10 = srcMatrix.atomGet( [ 1, 0 ] );
      var m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerVector.eSet( 0, atan2( m10, m11 ) );
      dstEulerVector.eSet( 1, 0 );
      dstEulerVector.eSet( 2, 0 );
    }
  }

  return dstEuler;
}

//

/**
  * Create the rotation matrix from a set of euler angles. Returns the created matrix.
  * Euler angles stay untouched.
  *
  * @param { Array } srcEuler - Source representation of Euler angles.
  * @param { Space } dstMatrix - Destination matrix.
  *
  * @example
  * // returns [ 0.7701, -0.4207, 0.4794,
  *              0.6224, 0.6599, - 0.4207,
  *              - 0.1393, 0.6224, 0.7701 ];
  * _.toMatrix2( null, [ 0.5, 0.5, 0.5, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0.4741, - 0.6142, 0.6307,
  * //           0.7384, 0.6675, 0.0950,
  * //           - 0.4794, 0.4207, 0.7701 ]
  * _.toMatrix2( null, [ 1, 0.5, 0.5, 2, 1, 0 ] );
  *
  * @returns { Space } Returns the corresponding rotation matrix.
  * @function toMatrix2
  * @throws { Error } An Error if( arguments.length ) is different than one.
  * @throws { Error } An Error if( srcEuler ) is not euler.
  * @memberof wTools.euler
  */

/* qqq : make similar to other converters */
/* qqq : because of name dstMatrix should be the second argument */

function toMatrix2( srcEuler, dstMatrix )
{

  var srcEuler = _.euler.from( srcEuler );
  var srcEulerVector = _.vector.from( srcEuler );

  _.assert( _.Space.is( dstMatrix ) || dstMatrix === null || dstMatrix === undefined );
  if( dstMatrix === null || dstMatrix === undefined )
  dstMatrix = _.Space.makeZero( [ 3, 3 ] );

  _.assert( dstMatrix.dims[ 0 ] === 3 );
  _.assert( dstMatrix.dims[ 1 ] === 3 );
  _.assert( arguments.length === 2 );

  var e1 = srcEulerVector.eGet( 0 );
  var e2 = srcEulerVector.eGet( 1 );
  var e3 = srcEulerVector.eGet( 2 );
  var ox = srcEulerVector.eGet( 3 );
  var oy = srcEulerVector.eGet( 4 );
  var oz = srcEulerVector.eGet( 5 );

  var ce1 = cos( e1 );
  var ce2 = cos( e2 );
  var ce3 = cos( e3 );
  var se1 = sin( e1 );
  var se2 = sin( e2 );
  var se3 = sin( e3 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - ce2*se3 );
    dstMatrix.atomSet( [ 0, 2 ], se2 );
    dstMatrix.atomSet( [ 1, 0 ], se1*se2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 1 ], -se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], -se1*ce2 );
    dstMatrix.atomSet( [ 2, 0 ], -ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 2, 1 ], ce1*se2*se3+ se1*ce3 );
    dstMatrix.atomSet( [ 2, 2 ], ce1*ce2 );
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - se2 );
    dstMatrix.atomSet( [ 0, 2 ], ce2*se3 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2 );
    dstMatrix.atomSet( [ 1, 2 ], ce1*se2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], se1*se2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se1*ce2 );
    dstMatrix.atomSet( [ 2, 2 ], se1*se2*se3 + ce1*ce3 );
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], se1*se2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 0, 2 ], se1*ce2 );
    dstMatrix.atomSet( [ 1, 0 ], ce2*se3 );
    dstMatrix.atomSet( [ 1, 1 ], ce2*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], -se2 );
    dstMatrix.atomSet( [ 2, 0 ], ce1*se2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 1 ], ce1*se2*ce3+ se1*se3 );
    dstMatrix.atomSet( [ 2, 2 ], ce1*ce2 );
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2 );
    dstMatrix.atomSet( [ 0, 1 ], - ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*se2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 0 ], se2 );
    dstMatrix.atomSet( [ 1, 1 ], ce2*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce2*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - se1*ce2 );
    dstMatrix.atomSet( [ 2, 1 ], se1*se2*ce3+ ce1*se3 );
    dstMatrix.atomSet( [ 2, 2 ], - se1*se2*se3 + ce1*ce3 );
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], - se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - se1*ce2 );
    dstMatrix.atomSet( [ 0, 2 ], se1*se2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*se2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - ce2*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se2 );
    dstMatrix.atomSet( [ 2, 2 ], ce2*ce3 );
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2 );
    dstMatrix.atomSet( [ 0, 1 ], ce1*se2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 1, 0 ], se1*ce2 );
    dstMatrix.atomSet( [ 1, 1 ], se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], se1*se2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - se2 );
    dstMatrix.atomSet( [ 2, 1 ], ce2*se3 );
    dstMatrix.atomSet( [ 2, 2 ], ce2*ce3 );
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2 );
    dstMatrix.atomSet( [ 0, 1 ], se2*se3 );
    dstMatrix.atomSet( [ 0, 2 ], se2*ce3 );
    dstMatrix.atomSet( [ 1, 0 ], se1*se2 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce3 - se1*ce2*se3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*se3 - se1*ce2*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], - ce1*se2 );
    dstMatrix.atomSet( [ 2, 1 ], se1*ce3 + ce1*ce2*se3  );
    dstMatrix.atomSet( [ 2, 2 ], - se1*se3 + ce1*ce2*ce3 );
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2 );
    dstMatrix.atomSet( [ 0, 1 ], - se2*ce3 );
    dstMatrix.atomSet( [ 0, 2 ], se2*se3 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*se2 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*ce2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], se1*se2 );
    dstMatrix.atomSet( [ 2, 1 ], se1*ce2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 2, 2 ], - se1*ce2*se3 + ce1*ce3 );
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], - se1*ce2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], se1*se2 );
    dstMatrix.atomSet( [ 0, 2 ], se1*ce2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 0 ], se2*se3 );
    dstMatrix.atomSet( [ 1, 1 ], ce2 );
    dstMatrix.atomSet( [ 1, 2 ], - se2*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], - ce1*ce2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 1 ], ce1*se2 );
    dstMatrix.atomSet( [ 2, 2 ], ce1*ce2*ce3 - se1*se3 );
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 0, 1 ], - ce1*se2 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*ce2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 0 ], se2*ce3 );
    dstMatrix.atomSet( [ 1, 1 ], ce2 );
    dstMatrix.atomSet( [ 1, 2 ], se2*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - se1*ce2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se1*se2 );
    dstMatrix.atomSet( [ 2, 2 ], - se1*ce2*se3 + ce1*ce3 );
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], - se1*ce2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - se1*ce2*ce3 - ce1*se3  );
    dstMatrix.atomSet( [ 0, 2 ], se1*se2 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*ce2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*se2 );
    dstMatrix.atomSet( [ 2, 0 ], se2*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se2*ce3 );
    dstMatrix.atomSet( [ 2, 2 ], ce2 );
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 0, 1 ], - ce1*ce2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*se2 );
    dstMatrix.atomSet( [ 1, 0 ], se1*ce2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 1 ], - se1*ce2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], se1*se2 );
    dstMatrix.atomSet( [ 2, 0 ], - se2*ce3 );
    dstMatrix.atomSet( [ 2, 1 ], se2*se3 );
    dstMatrix.atomSet( [ 2, 2 ], ce2 );
  }
  else
  {
    throw _.err( 'Not an Euler Representation.' );
  }

  return dstMatrix;
}

//

/**
  * Changes the representation of an euler Angle in one of two format ( 'xyz' or [ 0, 1, 2 ] ).
  * Euler representation stay untouched, dstEuler changes.
  *
  * @param { Array } representation - Source representation of Euler angles.
  * @param { Array } dstEuler - Source and destination Euler angle.
  *
  * @example
  * // returns [ 0, 0, 0, 2, 0, 2 ]
  * _.represent( [ 0, 0, 0, 0, 0, 0 ], [ 2, 0, 2 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 'yzx' ]
  * _.represent( [ 0, 0, 0, 1, 2, 0 ], 'yzx' );
  *
  * @returns { Array } Returns the destination Euler angle with the corresponding representation.
  * @function represent
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( dstEuler ) is not euler.
  * @throws { Error } An Error if( representation ) is not an euler angle representation.
  * @memberof wTools.euler
  */

function represent( dstEuler, representation )
{
  _.assert( dstEuler === null || dstEuler === undefined || _.euler.is( dstEuler ) );
  _.assert( _.arrayIs( representation ) || _.strIs( representation ) );
  _.assert( arguments.length === 2, 'expects two arguments' );

  if( dstEuler === null || dstEuler === undefined )
  dstEuler = [ 0, 0, 0, 0, 1, 2 ];

  var eulerArray = dstEuler.slice();
  var dstEulerVector = _.vector.from( dstEuler );
  var dstQuat = [ 0, 0, 0, 0 ];
  var gotQuaternion = _.euler.toQuat2( eulerArray, dstQuat );

  if( representation )
  {
    eulerArray = _.euler.make( eulerArray, representation );
  }

  eulerArray = _.euler.fromQuat2( eulerArray, gotQuaternion );
  _.vector.assign( dstEulerVector, eulerArray );
  return dstEuler;

}

//


/**
  * Check if a set of Euler angles is in a Gimbal Lock situation. Returns true if there is Gimbal Lock.
  * The Euler angles stay untouched.
  *
  * @param { Array } srcEuler - Source set of Euler angles.
  *
  * @example
  * // returns true
  * _.isGimbalLock( [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @example
  * // returns false
  * _.isGimbalLock( [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @returns { Bool } Returns true if there is Gimbal Lock, false if not.
  * @function isGimbalLock
  * @throws { Error } An Error if( arguments.length ) is different than one.
  * @throws { Error } An Error if( srcEuler ) is not an Euler angle.
  * @memberof wTools.euler
  */

function isGimbalLock( srcEuler )
{

  _.assert( arguments.length === 1 );
  _.assert( _.euler.is( srcEuler ) );

  var srcEuler = _.euler.from( srcEuler );
  var srcEulerVector = _.vector.fromArray( srcEuler );
  var accuracy =  _.accuracy;
  var accuracySqr = _.accuracySqr;

  var srcQuatVector = _.vector.fromArray( _.euler.toQuat2( srcEuler, null ) );
  var x = srcQuatVector.eGet( 0 ); var x2 = x*x;
  var y = srcQuatVector.eGet( 1 ); var y2 = y*y;
  var z = srcQuatVector.eGet( 2 ); var z2 = z*z;
  var w = srcQuatVector.eGet( 3 ); var w2 = w*w;

  var xy2 = 2*x*y; var xz2 = 2*x*z; var xw2 = 2*x*w;
  var yz2 = 2*y*z; var yw2 = 2*y*w; var zw2 = 2*z*w;

  var ox = srcEulerVector.eGet( 3 );
  var oy = srcEulerVector.eGet( 4 );
  var oz = srcEulerVector.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    var lim = xz2 + yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    var lim = xy2 - zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    var lim = yz2 - xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= -1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    var lim = xy2 + zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( ( xy2 + zw2 ) >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    var lim = yz2 + xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    var lim = xz2 - yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracy*accuracy )
    {
      return true;
    }
    else if( lim >= 1 - accuracy*accuracy)
    {
      return true;
    }
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    var lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    var lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr)
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    var lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    var lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    var lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    var lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= -1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }
  else
  {
    throw _.err( 'Not an Euler Representation.' );
  }

}


// --
// define class
// --

var Proto =
{

  is : is,
  isZero : isZero,

  make : make,
  makeZero : makeZero,

  zero : zero,

  from : from,
  _from : _from,
  representationSet : representationSet,

  fromAxisAndAngle : fromAxisAndAngle,
  fromQuat : fromQuat,
  fromMatrix : fromMatrix,
  toMatrix : toMatrix,

  fromQuat2 : fromQuat2,
  toQuat2 : toQuat2,
  fromMatrix2 : fromMatrix2,
  toMatrix2 : toMatrix2,

  represent : represent,
  isGimbalLock : isGimbalLock,

  // Order : Order,

}

_.mapExtend( Self,Proto );

})();
