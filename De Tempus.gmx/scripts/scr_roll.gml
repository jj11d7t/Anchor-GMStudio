//Set dodging to true
dash = true;

//Direction of Roll
if (!rollVal) {
    //Gets mouse position at time of activation so it doesn't change in real-time
    x1 = mouse_x;
    y1 = mouse_y;
    //Determine the direcion of the dash
    if (abs(x1 - x) < 25) {
        dir = "h";
    } else if (abs(y1 - y) < 25) {
        dir = "v";
    } else if (abs(x1 - x) - abs(y1 - y) < 25) {
        dir = "hv";
    }
    //Ensures that this code only runs once
    rollVal = true;
}

//Switch block to make sure dash is only done in one direction
switch (dir) {
    case "h": {
        if (y1 > y) vSpeed = scr_approach(vSpeed, 8, accl * 8);
        else if (y1 < y) vSpeed = scr_approach(vSpeed, -8, accl * 8);
    break;
    }
    case "v": {
        if (x1 < x) hSpeed = scr_approach(hSpeed, -8, accl * 8); 
        else if (x1 > x) hSpeed = scr_approach(hSpeed, 8, accl * 8);   
    break;
    }
    case "hv": {
        hSpeed = scr_approach(hSpeed, sign(mouse_x - x) * 8, accl * 8);
        if (global.xFace == 1) {
            if (global.yFace == 1) vSpeed = hSpeed; 
            else if (global.yFace == 0) vSpeed = -hSpeed;
        }
        else if (global.xFace == 0) {
            if (global.yFace == 1) vSpeed = -hSpeed;
            else if (global.yFace == 0) vSpeed = hSpeed;
        }
    }
    default: break;
}

//MoveSpeed Increase
maxSpeed = 10;

scr_moveCollide();
