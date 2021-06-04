//Squirrel Utilities
//Constants
Pi <- 3.14159265
TwoPi <- 6.2831853
HalfPi <- 1.5707963

Rad <- 0.01745329251994329576923690768489
Deg <- 57.295779513082320876798154814105

//==================//
//--Math Functions--//
//==================//
//Distance between the x/y components of two 3D vectors.
function Distance2D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	
	return sqrt((a*a)+(b*b));
}

//Distance between two 3D vectors.
function Distance3D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	local c = (v2.z-v1.z);
	
	return sqrt((a*a)+(b*b)+(c*c));
}

//Return the Pitch and Yaw between two 3D vectors.
function AngleBetween(v1,v2)
{
		local aZ = atan2((v1.y - v2.y),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),Distance2D(v1,v2))+Pi;
		
		return Vector(aY,aZ,0.0);
}

function AngleBetween2(v1,v2)
{
		local aZ = atan2((v1.z - v2.z),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),(v1.y - v2.y))+Pi;
		
		return Vector(aY,aZ,0.0);
}

//Returns the difference between two angles
//actionsnippet.com/?p=1451
function AngleDiff(angle0,angle1)
{
    return (abs((angle0 + Pi -  angle1)%(Pi*2.)) - Pi);
}

//Normalizes a vector
function Normalize(v)
{
	local len = v.Length();
	return Vector(v.x/len,v.y/len,v.z/len);
}

//Cross product of two vectors
function Cross(v1, v2) 
{
	local v = Vector(0.0,0.0,0.0);
	v.x = ( (v1.y * v2.z) - (v1.z * v2.y) );
	v.y = ( (v1.x * v2.z) - (v1.z * v2.x) );
	v.z = ( (v1.x * v2.y) - (v1.y * v2.x) );
	return v;
}

//Constrain a number to a given range
function clamp(v,mi,ma)
{
	if(v < mi) return mi;
	if(v > ma) return ma;
	return v;
}

//Return the biggest of two numbers.
function max(v1,v2)
{
	if(v1 > v2) return v1;
	return v2;
}

//Return the smallest of two numbers.
function min(v1,v2)
{
	if(v1 < v2) return v1;
	return v2;
}
//Vector multiplication fix
function Mul(v1,v2)
{
	local typ = typeof(v2);
	if(typ == "integer" || typ == "float")
	{
		return Vector(v1.x*v2,v1.y*v2,v1.z*v2);
	}
	if(typ == "Vector")
	{
		return Vector(v1.x*v2.x,v1.y*v2.y,v1.z*v2.z);
	}
	return null;
}

//=================//
//--Trace Helpers--//
//=================//
class TraceInfo 
{
	constructor(h,d)
	{
		Hit = h;
		Dist = d;
	}

	Hit = null;
	Dist = null;
}
//Returns the hit position of a trace between two points.
function TraceVec(start, end, filter)
{
	local dir = (end-start);
	local frac = TraceLine(start,end,filter);
	//return start+(dir*frac);
	return TraceInfo(start+(dir*frac),dir.Length());
}
//Returns the hit position of a trace along a normalized direction vector.
function TraceDir(orig, dir, maxd, filter)
{
	local frac = TraceLine(orig,orig+dir*maxd,filter);
	if(frac == 1.0) { return TraceInfo(orig+(dir*maxd),0.0);}
	return TraceInfo(orig+(dir*(maxd*frac)),maxd*frac);
}

//=================//
//--Debug Helpers--//
//=================//

//Draws a cross showing the X, Y, and Z axes.
function DrawAxis(pos,s,nocull,time)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}

//Draw the bounding box of a given entity.
function DrawEntityBBox(ent,r,g,b,a,time)
{
	DebugDrawBoxAngles(ent.GetOrigin(),ent.GetBoundingMins(), ent.GetBoundingMaxs(), ent.GetAngles(), r, g, b, a, time)
}

//Draws a line along a given normal.
function DrawNormal(pos,norm,s,time)
{
	local ns = norm*s;
	DebugDrawLine(Vector(pos.x,pos.y,pos.z), Vector(pos.x+ns.x,pos.y+ns.y,pos.z+ns.z), 0, 255, 255, false, time);	
}

