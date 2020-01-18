/*
 * Copyright (C) 2019 Marco Lochen
 *
 * This work is licensed under the Creative Commons Attribution 4.0
 * International License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 */

difference()
{
    intersection()
    {
        scale([1, 0.6, 0.75]) sphere(r = 50);
        translate([0, 0, 100]) cube([200, 200, 200], center = true);
    }
    #translate([0, 4, 64]) rotate([-10, 0, 0]) cube([78, 15, 122], center = true);
}
