/// @desc
alpha -= 0.01;
y_ -= 0.5;

size_x = lerp(size_x,1, 0.3);
size_y = lerp(size_x,1, 0.3);

if (alpha < 0) instance_destroy();