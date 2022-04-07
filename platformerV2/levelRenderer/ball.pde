class ball {
  float acc = 9.81;
  PVector pos, vel;
  float radius;
  float r, g, b;
  float mass = 1;
  PVector force, acceleration;

  boolean stop;
  ball(float r, PVector ball_pos, PVector dir, float red, float green, float blue, float m) {
    radius = r;
    pos = ball_pos;
    vel = dir;
    if (gravity) {
      force = new PVector(0, -9.81);
    } else {
      force = new PVector(0, 0);
    }
    acceleration = new PVector(0, 0);
    r = red;
    g = green;
    b = blue;
    mass = m;
  }
  void phy() {
    force.mult(frameRate);
    acceleration = (force.div(frameRate));
    vel.add(acceleration);
    pos.sub(vel);
  }
  void render() {
    fill(r, g, b);
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
  }
  void collision() {

    float decay = 1.2;

    if (pos.y + radius/2 >= height) {
      pos.y = height - radius/2;
      //force.y += 9.81;
      force.y += -vel.y*decay;
    }
    if (pos.y - radius/2 <= 0) {
      pos.y = 0 + radius/2;
      force.y += -vel.y*decay;
    }
    if (pos.x - radius/2 <= 0 ) {
      pos.x = 0 + radius/2;
      force.x += -decay* vel.x;
    }
    if (pos.x + radius/2 >= width) {
      pos.x = width - radius/2;
      force.x += -decay * vel.x;
    }
  }
  void ball_to_ball(int x) {
    if (balls_number > 1) {
      for (int i = x+1; i < balls_number; i++) {
        PVector difference = PVector.sub(balls_array[i].pos, pos);
        PVector supposed = difference.copy();
        if (difference.mag() < radius) {
          println("collided");
          supposed.setMag(radius);
          //balls_array[x].pos.sub(supposed.sub(difference));
          PVector momentum_resultant = PVector.add(balls_array[i].vel, vel);

          ////1 = vf1 - vf/vi1 - vi
          ////vi1 - vi * 1= vf1 - vf
          ////vi1 - vi= vf1 - vf
          ////vf1 = vi1 - vi + vf
          ////vf =  vi - vi1 + vf1)
          ////vi is local




          //local is 1
          //vel_final = vel - 1/1 * dot(a,b)/(magnatude of (pos - balls_array[i]))^2 * (pos - balls_array[i].pos);
          //vel_final = vel - 1/1 * c/(magnatude of (b) ^2 * b;
          PVector a = PVector.sub(vel, balls_array[i].vel);
          PVector b = PVector.sub(pos, balls_array[i].pos);
          float c = PVector.dot(a, b);
          float d = b.magSq();
          PVector vel_final = vel.sub(PVector.mult(b, (c/d)));
          println(b.heading());
          println(vel_final.heading());

          PVector e = PVector.sub(balls_array[i].vel, vel);
          PVector f = PVector.sub(balls_array[i].pos, pos);
          float g = PVector.dot(e, f);
          float h = f.magSq();
          PVector vel_final_2 = vel.sub(PVector.mult(f, (g/h)));

          float sine = sin(b.heading());
          float cosine = cos(b.heading());

          //float sine = sin(vel_final.heading());
          //float cosine = cos(vel_final.heading());

          //float force_temp_x = force.x;
          //float force_temp_y = force.y;
          //float force_other_x = balls_array[i].force.x;
          //float force_other_y = balls_array[i].force.y;

          force.add(PVector.sub(vel, vel_final));
          balls_array[i].force.add(PVector.sub(balls_array[i].vel, vel_final_2));

          //force.x -= sine * force_other_x * 2;
          //force.y -= cosine * force_other_y * 2;
          //balls_array[i].force.x -= -sine * force_temp_x * 2;
          //balls_array[i].force.y -= -cosine * force_temp_y * 2;







          balls_array[x].pos.sub(supposed.sub(difference));
          //println(temp_vel.mag());
        }
      }
    }
  }

  void hit() {
    //force.mult(-1);
  }
  void force() {
  }
}
