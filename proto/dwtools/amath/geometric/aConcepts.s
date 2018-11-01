(function _aConcepts_s_() {

'use strict';

/**
  @module Tools/math/Concepts - Collection of functions to operate such geometrical concepts as Sphere, Box, Plane, Frustum, Ray, Axis and Angle, Euler's Angles, Quaternion and other. Why MathConcepts? Three reasons. All functions of the module are purely functional. MathConcepts heavily relies on another great concept MathVector what makes the module less sensible to data formats of operational objects. The module provides functions for conversions from one to another conceptual form, for example from Quaternion to Euler's Angles or from Euler's Angles to Quaternion or between different representations of Euler's Angles. Unlike MatchConcepts many alternatives do conversions inconsistently or inaccurately. MatchConcepts is densely covered by tests and optimized for accuracy. Use MatchConcepts to have uniform experience solving geometrical problems and to get a more flexible program.
*/

/**
 * @file geometric/Concepts.s.
 */

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  let _ = _global_.wTools;

  _.include( 'wMathScalar' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  require( './Box.s' );
  require( './Capsule.s' );
  require( './Frustum.s' );
  require( './Line.s' );
  require( './Plane.s' );
  require( './Ray.s' );
  require( './Segment.s' );
  require( './Sphere.s' );

  require( './AxisAndAngle.s' );
  require( './Quat.s' );
  require( './Euler.s' );

}

})();