/*
 * Copyright (C) 2019 Marco Lochen
 *
 * This work is licensed under the Creative Commons Attribution 4.0
 * International License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 */

qinch = 25.4 * 1.25;
width = 60;
height = 53;

module rounded_cube(x, y, z, r)
{
    hull()
    {
        translate([-x / 2 + r, -y / 2 + r, 0]) cylinder(r = r, h = z, $fn = 16);
        translate([x / 2 - r, -y / 2 + r, 0]) cylinder(r = r, h = z, $fn = 16);
        translate([-x / 2 + r, y / 2 - r, 0]) cylinder(r = r, h = z, $fn = 16);
        translate([x / 2 - r, y / 2 - r, 0]) cylinder(r = r, h = z, $fn = 16);
    }
}

module case_layer(h)
{
    difference()
    {
        rounded_cube(width, height, h, 5);
        translate([-width / 2 + 5, -height / 2 + 5, -1]) cylinder(r = 2.5, h = h + 2, $fn = 16);
        translate([width / 2 - 5, -height / 2 + 5, -1]) cylinder(r = 2.5, h = h + 2, $fn = 16);
        translate([-width / 2 + 5, height / 2 - 5, -1]) cylinder(r = 2.5, h = h + 2, $fn = 16);
        translate([width / 2 - 5, height / 2 - 5, -1]) cylinder(r = 2.5, h = h + 2, $fn = 16);
    }
}

module front()
{
    difference()
    {
        union()
        {
            cylinder(r = qinch / 2 - 0.1, h = 24, $fn = 64);
            cylinder(r1 = 26, r2 = 20, h = 8, $fn = 32);
            case_layer(3);
        }
        cylinder(r = qinch / 2 - 4, h = 100, $fn = 32, center = true);
    }
}

module middle()
{
    difference()
    {
        union()
        {
            difference()
            {
                case_layer(8);
                translate([0, 0, -1]) rounded_cube(44, 37, 12, 2);
            }
            translate([-15.5, 0, 2]) cube([16, 38, 4], center = true);
            translate([15.5, 0, 2]) cube([16, 38, 4], center = true);
        }
        translate([-10.5, -0.1, 0]) cylinder(r = 0.5, h = 20, $fn = 8, center = true);
        translate([10.5, 0.1, 0]) cylinder(r = 0.5, h = 20, $fn = 8, center = true);
        translate([-10.5, 12.4, 0]) cylinder(r = 0.5, h = 20, $fn = 8, center = true);
        translate([10.5, 12.4, 0]) cylinder(r = 0.5, h = 20, $fn = 8, center = true);
        
        translate([0, -20, 8]) cube([18, 20, 4], center = true);
    }
}

module back()
{
    difference()
    {
        case_layer(3);
        translate([0, 0, 1]) rounded_cube(44, 37, 12, 2);
    }
}

front();
translate([65, 0, 0]) middle();
translate([130, 0, 0]) back();
