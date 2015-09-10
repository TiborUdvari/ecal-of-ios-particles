#include "ofApp.h"




//--------------------------------------------------------------
void ofApp::setup(){
    
    int nmbrparticle = 10000;
    for (int i = 0; i < nmbrparticle; i++) {
        
        Particle p = Particle();
        p.setup();
        particles.push_back(p);
    }
    
    repulsionPoint.set(ofGetWindowWidth()/2, ofGetWindowHeight()/2);
    
    for (int i = 0; i < 5; i++) {
        ofVec2f pointTemp = ofVec2f(ofRandom(ofGetWindowWidth()), ofRandom(ofGetWindowHeight()));
        attractionPoints.push_back(pointTemp);
    }
    
    
    // 0 output channels,
    // 2 input channels
    // 44100 samples per second
    // 256 samples per buffer
    // 4 num buffers (latency)
    
    soundStream.listDevices();
    
    
    //if you want to set a different device id
    //soundStream.setDeviceID(0); //bear in mind the device id corresponds to all audio devices, including  input-only and output-only devices.
    
    int bufferSize = 256;
    
    
    left.assign(bufferSize, 0.0);
    right.assign(bufferSize, 0.0);
    
    //if you want to set a different device id
    //soundStream.setDeviceID(0); //bear in mind the device id corresponds to all audio devices, including  input-only and output-only devices.
    
    soundStream.setup(this, 0, 2, 44100, bufferSize, 4);
    
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    mouseAttractionPoint.set(0,0);
    //mouseAttractionPoint.set(ofGetMouseX(), ofGetMouseY());
    
    ofVec2f gravity = ofVec2f (0, 0);
    noiseCounter += 0.01;
    ofVec2f wind = ofVec2f ((ofNoise(noiseCounter)-0.5) * 10, 0);
    
    for (int i = 0;i < particles.size() ; i++ ) {
        Particle &pTemp = particles[i];
        
        pTemp.update();
        pTemp.applyForce(gravity);
        ofVec2f friction = ofVec2f (particles[i].acceleration);
        pTemp.applyForce(friction.normalize() * 2);
        pTemp.applyForce(wind);
        
        for (int i = 0; i < attractionPoints.size(); i++) {
            ofVec2f pointForce = attractionPoints[i] - pTemp.location;
            
            ofVec2f forceApplied = pointForce.normalize()*1;
            float dist = pointForce.length();
            
            pTemp.applyForce(forceApplied / dist);
        }
        
        ofVec2f pointForce = mouseAttractionPoint - pTemp.location;
        pTemp.applyForce(pointForce.normalize()*30);
        
        ofVec2f repulsionForce = pTemp.location - repulsionPoint;
        pTemp.applyForce(repulsionForce.normalize() * repulsorPower);
        
    }
}
//--------------------------------------------------------------
void ofApp::draw(){
    
    ofBackground(0);
    
    //    for (int i = 0; i < attractionPoints.size(); i++) {
    //        ofSetColor(255, 0, 0);
    //        ofCircle(attractionPoints[i], 10);
    //    }
    ofSetColor(0);
    
    for (int i = 0; i < particles.size(); i++) {
        particles[i].draw();
        checkEdges(particles[i]);
    }
    
    ofSetColor(0, 0, 255);
    ofCircle(mouseAttractionPoint.x, mouseAttractionPoint.y, 2);
}

void ofApp::checkEdges(Particle &p){
    if (p.location.y > ofGetWindowHeight() ){
        p.location.y = ofGetWindowHeight();
        p.velocity *= ofVec2f(1,-1);
        p.applyForce(-p.velocity);
    }
    else if (p.location.y < 0){
        p.location.y = 0;
        p.velocity *= ofVec2f(1,-1);
        p.applyForce(-p.velocity);
    }
    else if(p.location.x > ofGetWindowWidth()) {
        p.location.x = ofGetWindowWidth();
        p.velocity *= ofVec2f(-1,1);
        p.applyForce(-p.velocity);
    }
    else if (p.location.x < 0){
        p.location.x = 0;
        p.velocity *= ofVec2f(-1,1);
        p.applyForce(-p.velocity);
    }
}


void ofApp::audioIn(float * input, int bufferSize, int nChannels){
    
    float curVol = 0.0;
    
    // samples are "interleaved"
    int numCounted = 0;
    
    //lets go through each sample and calculate the root mean square which is a rough way to calculate volume
    
    cout << input[0] << endl;
    
    for (int i = 0; i < bufferSize; i++){
        left[i]		= input[i*2]*0.5;
        right[i]	= input[i*2+1]*0.5;
        
        curVol += left[i] * left[i];
        curVol += right[i] * right[i];
        numCounted+=2;
    }
    
    //this is how we get the mean of rms :)
    curVol /= (float)numCounted;
    
    // this is how we get the root of rms :)
    curVol = sqrt( curVol );
    
    cout << repulsorPower;
    repulsorPower = curVol * 1000;
    
    
    /*
     smoothedVol *= 0.93;
     smoothedVol += 0.07 * curVol;
     */
    //bufferCounter++;
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}


