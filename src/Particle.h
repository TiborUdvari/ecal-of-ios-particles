//
//  Particle.h
//  ecal_particles_system
//
//  Created by Elise Migraine on 09.09.15.
//
//

#ifndef __ecal_particles_system__Particle__
#define __ecal_particles_system__Particle__

#include <stdio.h>
#include "ofMain.h"

class Particle {
    
public:
    void setup();
    void update();
    void draw();
    
    void applyForce(ofVec2f force);

    ofVec2f location;
    ofVec2f velocity;
    float maxSpeed;
    
    ofVec2f acceleration;
    
    float mass;
    float rayon;
    
};

#endif /* defined(__ecal_particles_system__Particle__) */














