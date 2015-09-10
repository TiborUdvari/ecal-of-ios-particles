//
//  Particle.cpp
//  ecal_particles_system
//
//  Created by Elise Migraine on 09.09.15.
//
//

#include "Particle.h"

void Particle::setup(){
    
    float x = ofRandom(ofGetWindowWidth());
    float y = ofRandom(ofGetWindowHeight());
    location.set(x, y);
    velocity.set(0,0);
    maxSpeed = 10;
    
    acceleration.set(0, 0);
    mass = ofRandom(35, 36);
    rayon = mass * 0.1;
}
void Particle::update(){

    float magn = velocity.length();
    velocity = velocity.normalize() * ofClamp(magn, 0, maxSpeed);
    velocity += acceleration;
    
    location = location + velocity;
    acceleration *= 0;
}

void Particle::draw(){
    
    ofSetColor(255);
    ofCircle(location.x, location.y, 1);
    
}

void Particle::applyForce(ofVec2f force){
    acceleration += force/mass;
}























