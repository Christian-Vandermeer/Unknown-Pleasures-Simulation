void setup() {
  size(600, 600);  // Sets window size
  background(0);   // Background is black (0)
  stroke(255);     // sets the color used to draw lines and borders around shapes
                   // The value 255 corresponds to white in the grayscale color model
  noFill();        // This function disables filling of shapes
                   // Normally, shapes like rectangles and ellipses are filled with the current fill color
}


void draw() {
  background(0); // Clear screen every frame
  
  int lines = 80; // Number of waveforms
  float spacing = height / (lines + 2);
  
  for (int i = 0; i < lines; i++) {
    float y = spacing * (i + 1);
    drawWaves(y, i, spacing);
  }
}

void drawWaves(float y, int index, float spacing) {
  beginShape();
  for (float x = 50; x < width - 50; x += 5) {
    // Base distortion, always on
    float baseNoise = noise(x * 0.01, index * 0.1, frameCount * 0.01); 
    float baseDistortion = map(baseNoise, 0, 1, -10, 10); // Small random noise
    
    // Calculate the distance from the cursor to this line
    float distance = abs(mouseX -x); 
    
    // Randomized range for cursor effect
    float range = spacing * (random(15, 8)); // Randomize range between 8x and 8x the line spacing
    
    // Apply gradual distortion if within the randomized range
    float cursorEffect = 0;
    if (distance < range) {
      // Gradual falloff of intensity
      float intensity = exp(-pow(distance / range, 2) * 0.5) * 70; // Exponential drop-off
      
      // Apply random noise for the cursor effect
      float cursorNoise = noise(x * 0.02, index * 0.1, frameCount * 0.1); 
      cursorEffect = map(cursorNoise, 0, 1, -intensity, intensity); // Controlled by intensity
    }
    
    // Combine base distortion with cursor effect and draw the vertex
    vertex(x, y + baseDistortion + cursorEffect);
  }
  endShape();
}
