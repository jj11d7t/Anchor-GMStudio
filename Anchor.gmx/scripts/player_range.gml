speed = 0;
maxSpeed = 1;

hMove = input_key_right() + -input_key_left();
vMove = input_key_down() + -input_key_up();

hSpeed+=hMove*accl;
vSpeed+=vMove*accl;

hSpeed = clamp(hSpeed, -maxSpeed, maxSpeed);
vSpeed = clamp(vSpeed, -maxSpeed, maxSpeed);

frc = accl * 0.95;

hSpeed = Friction(hSpeed, frc);
vSpeed = Friction(vSpeed, frc);

hSpeedFinal = hSpeed + hSpeedFrac;
hSpeedFrac = hSpeedFinal - floor(abs(hSpeedFinal)) * sign(hSpeedFinal);
hSpeedFinal -= hSpeedFrac;

vSpeedFinal = vSpeed + vSpeedFrac;
vSpeedFrac = vSpeedFinal - floor(abs(vSpeedFinal)) * sign(vSpeedFinal);
vSpeedFinal -= vSpeedFrac;

if (place_meeting(x + hSpeedFinal, y, class_wall)) {
    inc = sign(hSpeedFinal);
    while (!place_meeting(x + inc, y, class_wall)) x+=inc;
    hSpeed = 0;
    hSpeedFinal = 0;
}
x+=hSpeedFinal;

if (place_meeting(x, y + vSpeedFinal, class_wall)) {
    inc = sign(vSpeedFinal);
    while (!place_meeting(x, y + inc, class_wall)) y+=inc;
    vSpeed = 0;
    vSpeedFinal = 0;
}
y+=vSpeedFinal;

if (place_meeting(x, y, class_damage) && !invulnerable) {
    alarm_set(0, room_speed * 2);
    alarm_set(1, room_speed/4);
    invulnerable = true;
    state_switch("Damage", true);
}
