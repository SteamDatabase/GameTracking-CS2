FLOORHEIGHT <- 0.0625;

ELEVATOR_MOVING <- false;

IN_TRANSIT <- false;

TARGET_FLOOR <- 0;

function Think()
{
	local MoveVector = self.GetVelocity();

	if (MoveVector.z != 0)
		{
		ELEVATOR_MOVING = true;
		}
		else
		{
		ELEVATOR_MOVING = false;
		}
		
		if (IN_TRANSIT == true && ELEVATOR_MOVING == false)
			{
			EntFire("elevator.relay.endmove", "Trigger", 0, 0);
			IN_TRANSIT = false;
			}

}


function SetTargetFloor( floor )
{

TARGET_FLOOR = floor;
printl ("ELEVATOR: Floor received, set to " + TARGET_FLOOR);

}


function MoveToFloor()
{
local movedistance = TARGET_FLOOR * FLOORHEIGHT;

EntFire("elevator.mover", "SetPosition", movedistance, 0);

printl ("ELEVATOR: moving to floor " + TARGET_FLOOR + ", which is at position " + movedistance);

IN_TRANSIT = true;
}




function TestMove()
{
local randomfloor = RandomInt(2, 14)
TARGET_FLOOR = randomfloor;
printl (randomfloor);

MoveToFloor();
}