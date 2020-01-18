/*
 * Copyright (C) 2017 Marco Lochen
 *
 * This work is licensed under the Creative Commons Attribution 4.0
 * International License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 */

ro = 8;                     // radii on the outside
ri = 2;                     // radii on the inside
rf = 3;                     // radii on the front
offset = 46;                // offset for corner parts
gap = 0.3;                  // gap for places where parts are joined
lh = 16.5 + 2 * gap;        // height of the bottom part of the laptop
$fn = 16;

module hull_corners(back = false)
{
    d = back ? 16 : 22;
    translate([-ro + ri, d - ri]) circle(r = ri);
    translate([ro - ri, d - ri]) circle(r = ri);
}

module nut_insert(back = false)
{
    d = back ? 14 : 20;
    translate([0, d - ((5 + 2 * gap) / 2)]) square([10 + 2 * gap, 5 + 2 * gap], center = true);
}

module front()
{
    offset = (ro - rf) / tan(22.5);
    hull()
    {
        translate([offset - 8, ro + lh + rf]) circle(r = rf);
        translate([offset, ro + lh + rf]) circle(r = rf);
    }       
    hull()
    {
        translate([offset, ro + lh + rf]) circle(r = rf);
        translate([offset, ro - rf]) circle(r = rf);
        translate([offset + (lh + 2 * rf) / 2, ro - rf + (lh + 2 * rf) / 2]) circle(r = 3);
    }
    hull()
    {
        circle(r = ro);
        translate([offset, ro - rf]) circle(r = rf);
    }
}

module parts_2D()
{
    difference()
    {
        union()
        {
            hull()
            {
                circle(r = ro);
                rotate(90) hull_corners();
                rotate(45) hull_corners();
            }
            rotate(-45) front();
        }
        circle(r = 3 + gap);
        rotate(90) nut_insert();
        rotate(45) nut_insert();
    }

    translate([-offset, 0]) difference()
    {
        hull()
        {
            circle(r = ro);
            rotate(-90) hull_corners();
            rotate(-22.5) hull_corners(back = true);
        }
        circle(r = 3 + gap);
        rotate(-90) nut_insert();
        rotate(-22.5) nut_insert(back = true);
    }

    rotate(-45) translate([-offset, 0]) difference()
    {
        hull()
        {
            circle(r = ro);
            rotate(-90) hull_corners();
            rotate(202.5) hull_corners(back = true);
        }
        circle(r = 3 + gap);
        rotate(-90) nut_insert();
        rotate(202.5) nut_insert(back = true);
    }
}

module parts_3D()
{
    difference()
    {
        linear_extrude(12, convexity = 6) parts_2D();
        translate([-0.5 * offset, 0, 6]) rotate([0, 90, 0])
            cylinder(r = 3 + gap, h = offset - 2 * 18, center = true);
        rotate([0, 0, -45]) translate([-0.5 * offset, 0, 6]) rotate([0, 90, 0])
            cylinder(r = 3 + gap, h = offset - 2 * 18, center = true);
        rotate([0, 0, -22.5]) translate([-offset * cos(22.5), 0, 6]) rotate([90, 0, 0])
            cylinder(r = 3 + gap, h = 10, center = true);
        rotate([0, 0, -22.5]) translate([-offset * cos(22.5), 2, 12])
            cube([6 + 2 * gap, 4, 12], center = true);
    }
}

translate([0, ro + 1, 0]) parts_3D();
mirror([0, 1, 0]) translate([0, ro + 1, 0]) parts_3D();
