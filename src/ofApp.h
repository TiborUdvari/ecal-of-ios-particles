#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "Particle.h"

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    void checkEdges(Particle &p);
    vector<Particle> particles;
    
    float noiseCounter = 0;
    
    ofVec2f mouseAttractionPoint;
    float mouseAttractionForce;

    ofVec2f repulsionPoint;
    
    vector<ofVec2f> attractionPoints;
    
    void audioIn(float * input, int bufferSize, int nChannels);
    ofSoundStream soundStream;
    
    vector <float> left;
    vector <float> right;
    
    float repulsorPower;
    
};

