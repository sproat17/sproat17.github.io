import processing.video.*;
import grafica.*; // https://github.com/jagracar/grafica/blob/master/examples refrenced for grapgh
import javax.swing.JColorChooser;
import java.awt.Color;

PImage back, calandar, forward, health, light, news, notification, tools, weather, power, setting, scale, sleep, time, walk, cloudy, partly, snowy, stormy, backImg, check, uncheck, fitness;
PShape mediumBox, newsBox, smallBox, topBox, dayBox;

color c = color(255, 255, 255);
Color javaColor;

boolean settings = false;
boolean mirror = false;
boolean bScale = false;
boolean bSleep, bTime, bWalk;
boolean politics = true;
boolean economics = true;
boolean sports = true;
boolean technology = true;

Table weatherTable;
Table newsTable;
Capture cam;


String [] days= {"today", "yesterday", "10/29", "10/28", "10/27", "10/26", "10/25"};
String [] possibleDays = {"Sunday", "Monday", "Tuesday", "Wedsday", "Thursday", "Friday", "Saturday"};
String [] loadedArticles = {"today", "today", "yesterday", "10/29", "10/28", "10/27", "11/5", "10/25", "yesterday", "10/29", "10/28", "10/27", "10/26", "10/25"};
int newsArticle = 0;
int newsRows = 0;
int clickedNotification = 255;


void setup() {
  size(1200, 1000, P2D);

  //get camera
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();

  //load icons
  back = loadImage("back.png");
  calandar = loadImage("calandar.png");
  forward = loadImage("forward.png");
  health = loadImage("health.png");
  light = loadImage("light.png");
  news = loadImage("news.png");
  notification = loadImage("notification.png");
  tools = loadImage("tools.png");
  weather = loadImage("weather.png");
  setting = loadImage("settings.png");
  power = loadImage("power.png");
  scale = loadImage("scale.png");
  sleep = loadImage("sleep.png");
  time = loadImage("time.png");
  walk = loadImage("walk.png");
  cloudy = loadImage("cloudy.png");
  partly = loadImage("partly.png");
  snowy = loadImage("snowy.png");
  stormy = loadImage("stormy.png");
  backImg = loadImage("/home/edward/code/p1__Edward_Sproat/background.jpg");
  fitness = loadImage("fitness.jpg");
  check = loadImage("check.png");
  uncheck = loadImage("uncheck.png");



  fill(255, 255, 255, 100);
  mediumBox = createShape(RECT, 0, 0, width/10, height/10);
  newsBox = createShape(RECT, 0, 0, width * .8, height/15);
  smallBox = createShape(RECT, 0, 0, width * .1, height/15);
  topBox = createShape(RECT, 0, 0, width/2, height/10);
  dayBox = createShape(RECT, 0, 0, 800*.1, 600/15);

  newsTable = loadTable("/home/edward/Desktop/testTicker/sketch_221102a/data/newsData.csv", "header");


  //get news from file
  for (TableRow row : newsTable.rows()) {

    String newsString = row.getString("newsString");
    String genre = row.getString("genre");
    /*
    if(genre.equals("Sports") && sports){
     loadedArticles[newsRows] = (genre + ": " + newsString);
     newsRows++;
     }
     
     if(genre.equals("Politics") && politics){
     loadedArticles[newsRows] = (genre + ": " + newsString);
     newsRows++;
     }
     
     if(genre.equals("Economics") && economics){
     loadedArticles[newsRows] = (genre + ": " + newsString);
     newsRows++;
     }
     
     if(genre.equals("Technology") && technology){
     loadedArticles[newsRows] = (genre + ": " + newsString);
     newsRows++;
     }
     
     */

    loadedArticles[newsRows] = (genre + ": " + newsString);
    newsRows++;
  }
}


void draw() {

  tint(c, 100);

  //get time
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
  String time;
  
  if (m > 10) {
    time = Integer.toString(h) + ":" + Integer.toString(m);
  } else {
    time = Integer.toString(h) + ":0" + Integer.toString(m);
  }



  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0, width, height);


  if (mirror) {

    //top
    fill(0);
    textSize(width/25);
    shape(smallBox, 0, 0);
    image(power, 35, 6);
    shape(smallBox, width * .1, 0);
    image(setting, width * .1 + 35, 5);
    shape(smallBox, width * .2, 0);
    fill(clickedNotification, 0, 0, 100 * clickedNotification);
    rect(width * .2, 0, width * .1, height/15);
    image(notification, width * .2 + 33, 5);
    fill(0);
    shape(smallBox, width * .9, 0);
    text(time, width * .9+ 10, 50);



    // left side bars
    shape(mediumBox, 0, height/3);
    image(health, width/50, height/3 + width/60);
    shape(mediumBox, 0, height/3 + height/10);
    image(calandar, width/40, height/3 +  height/10 + width/50);
    shape(mediumBox, 0, height/3 + height/5);
    image(weather, width/45, height/3 + height/5 + width/50);

    if (settings) {
      // right side bars
      shape(mediumBox, width - width/10, height/3);
      image(tools, width - width/10 + width/32.5, height/3 + width/50);
      shape(mediumBox, width - width/10, height/3 + height/10);
      image(light, width - width/10 + width/30, height/3 + height/10 + width/50);
      shape(mediumBox, width - width/10, height/3 + height/5);
      image(news, width - width/10 + height/25, height/3 + height/5 + height/50);
    }

    //bottom bars
    textSize(20);
    shape(newsBox, 0, height - height/15);
    text(loadedArticles[newsArticle], 0, height - 25);
    shape(smallBox, width * .8, height - height/15);
    image(back, width * .8 + width/35, height - height/15 + width/120);
    shape(smallBox, width * .9, height - height/15);
    image(forward, width * .9 + width/35, height - height/15 + width/120);
  } else {
    //what to display if power is off
    // add feedback to buttons
    shape(smallBox, 0, 0);
    image(power, 35, 6);
  }
}

void mouseClicked() {

  //detect if user clicks G button
  //distance = Math.sqrt((mouseX-width/5) * (mouseX-width/5) + (mouseY-7.5*height/12) * (mouseY-7.5*height/12));

  if (mouseX >= 0 && mouseX <= width * .1  && mouseY >= 0 && mouseY <= height/15) {
    println("power");
    mirror = !mirror;
  }

  //mirror has to be on to press buttons except power
  //calcualte where clicked and exectute new applet
  if (mirror) {
    if (mouseX >= 0 && mouseX <= width/10 && mouseY >= height/3 && mouseY <= (height/3 + height/10)) {
      HealthWindow healthWindow = new HealthWindow();
      runSketch(new String[]{"HealthWindow"}, healthWindow);
    }


    //if click calandar button turn off the lights off settings button
    if (mouseX >= 0 && mouseX <= width/10 && mouseY <= (height/3 + height/10 + height/10) && mouseY >= (height/3 + height/10)) {
      CalandarWindow calandarWindow = new CalandarWindow();
      runSketch(new String[]{"CalandarWindow"}, calandarWindow);
    }

    if (mouseX >= 0 && mouseX <= width/10 && mouseY <= (height/3 + height/10 + height/10 + height/10) && mouseY >= (height/3 + height/10 + height/10)) {
      WeatherWindow weatherWindow = new WeatherWindow();
      runSketch(new String[]{"weatherWindow"}, weatherWindow);
    }

    if (mouseX >= width - width/10 && mouseX <= width && mouseY >= height/3 && mouseY <= (height/3 + height/10)) {
      ToolsWindow toolsWindow = new ToolsWindow();
      runSketch(new String[]{"ToolsWindow"}, toolsWindow);
    }

    if (mouseX >= width - width/10 && mouseX <= width  && mouseY <= (height/3 + height/10 + height/10) && mouseY >= (height/3 + height/10)) {
      LighthWindow lighthWindow = new LighthWindow();
      runSketch(new String[]{"LighthWindow"}, lighthWindow);
    }

    if (mouseX >= width - width/10 && mouseX <= width  && mouseY <= (height/3 + height/10 + height/10 + height/10) && mouseY >= (height/3 + height/10 + height/10)) {
      NewsWindow newsWindow = new NewsWindow();
      runSketch(new String[]{"NewsWindow"}, newsWindow);
    }

    if (mouseX >= width * .8 && mouseX <= width * .9  && mouseY <= height && mouseY >= height - height/15) {
      println("back");
      if (newsArticle<1) {
        newsArticle = newsRows;
      } else {
        newsArticle--;
      }
    }

    if (mouseX >= width * .9 && mouseX <= width  && mouseY <= height && mouseY >= height - height/15) {
      println("right");
      if (newsArticle<newsRows-1) {
        newsArticle++;
      } else {
        newsArticle = 0;
      }
    }



    if (mouseX >= width * .1 && mouseX <= width * .2  && mouseY >= 0 && mouseY <= height/15) {
      println("settings");
      settings = !settings;
    }

    if (mouseX >= width * .2 && mouseX <= width * .3   && mouseY >= 0 && mouseY <= height/15) {
      if (clickedNotification != 0) {
        NotificationWindow notificationWindow = new NotificationWindow();
        runSketch(new String[]{"Notifications"}, notificationWindow);
      }
      clickedNotification = 0;
    }
  }
}

class HealthWindow extends PApplet {

  public void settings() {
    size(800, 600);
  }

  public void draw() {
    
    //background
    background(255, 255, 255);
    tint(200, 150, 0, 100);
    fitness.resize(800, 600);
    image(fitness, 0, 0);

    //icons
    image(sleep, 800 * .20-50, 600/7);
    image(scale, 800 * .40-30, 600/7);
    image(walk, 800 * .60, 600/7);
    image(time, 800 *.8, 600/7);
    
    //icon text
    fill(0);
    textSize(21);
    text("Sleep", 800 * .20-50, 600/7 + 70);
    text("Weight", 800 * .40- 35, 600/7 + 70);
    text("Excersize", 800 * .6 - 18, 600/7 + 70);
    text("Screen Time", 800 * .8 - 25, 600/7 + 70);



    if (bScale) {

      // Prepare the points for the plot
      Table table = loadTable("/home/edward/code/p1__Edward_Sproat/data/weightData.csv", "header");
      int nPoints = 7;
      GPointsArray points = new GPointsArray(nPoints);



      //load data
      for (int row = 0; row < table.getRowCount(); row++) {
        float dates  =table.getFloat(row, "date");
        float weight = table.getFloat(row, "weight");
        points.add(dates, weight);
      }

      // Create a new plot and set its position on the screen
      GPlot plot = new GPlot(this);
      plot.setPos(800/5, 600/3);


      // Set the plot title and the axis labels
      plot.setTitleText("Weight Tracker");
      plot.getXAxis().setAxisLabelText("Date");
      plot.getYAxis().setAxisLabelText("Weight (lbs)");

      // Add the points
      plot.setPoints(points);

      //axis
      plot.getXAxis().setTickLabels(days);


      // Draw it!
      plot.defaultDraw();
    } else {
      textSize(70);
      fill(255, 0, 0);
      text("Your Health Score: 78", 100, 600/2);

      textSize(30);
      fill(255, 0, 0);
      text("Click HERE to see how calcualted", 200, 500);
    }
  }

  public void mouseClicked() {

    if (mouseX >= 800 * .20-50 && mouseX <= 50 + (800 * .20-50)  && mouseY >= 600/7 && mouseY <= 50 + 600/7) {
      bSleep = !bSleep;
      println("sleep");
    }

    if (mouseX >= 800 * .40-30 && mouseX <= 50 + (800 * .40-30)  && mouseY >= 600/7 && mouseY <= 50 + 600/7) {
      bScale = !bScale;
      println("scale");
    }
  }
}

class CalandarWindow extends PApplet {

  String [] months = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
  String [] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wedensday", "Thursday", "Friday", "Saturday"};


  public void settings() {
    size(800, 600);
  }

  public void draw() {

    background(255, 255, 255);

    int mo = month();
    int y = year();
    int d = day();

    //header of calaendar
    String header = (months[mo-1]) + " " + y;
    fill(0);
    textSize(70);
    textAlign(CENTER);
    text(header, 400, 100);

    //display heading for boxes
    textSize(20);
    for (int i = 0; i< 7; i++) {
      text(daysOfWeek[i], 100*i + 100, 175);
    }

    triangle(670, 58, 670, 98, 725, 78);
    triangle(135, 58, 135, 98, 80, 78);


    textAlign(BOTTOM, LEFT);

   
    int c = 1;
    int n = 1;
    int start = 2;

    //display calanedar
    for (int i = 0; i< 7; i++) {
      c = n;
      for (int j= 0; j< 5; j++) {
        if (c-start == d) {
          fill(255, 0, 0);
          text(c-start, 100*i + 65, 75*j + 215);
          shape(dayBox, 100*i + 60, 75 * j + 200);
          fill(0);
        } else {
          shape(dayBox, 100*i + 60, 75 * j + 200);
          if ((c-start) > 0 && (c-start) < 31) {
            text(c -start, 100*i + 65, 75*j + 215);
          }
          if ((c-start) == 24) {
            text(c -start, 100*i + 65, 75*j + 215);
            textSize(12);
            fill(0, 0, 255);
            text("Thanksgiving", 100*i + 65, 75*j + 235);
            textSize(20);
            fill(0);
          }
        }
        c += 7;
      }
      n += 1;
    }
  }
}


class WeatherWindow extends PApplet {

  public void settings() {
    size(600, 600);
  }

  public void draw() {

    //draw weahter background
    background(255, 255, 255);
    tint(0, 150, 200, 100);
    image(backImg, 0, 0);
    fill(0);
    textSize(50);
    text("Weather Forecast", 115, 50);
    line(50, 60, 550, 60);
    tint(255, 255, 255);

    weatherTable = loadTable("/home/edward/Desktop/testingHealth (copy 1)/test/data/weatherData.csv", "header");

    int i = 0;

    for (TableRow row : weatherTable.rows()) {

      String day = row.getString("day");
      String cloud = row.getString("cloud");
      String high = row.getString("high");
      String low = row.getString("low");


      //draw weather
      //tint(0, 0, 0);
      textSize(30);

      text(day, 50, 115 + 75 * i);

      if (cloud.equals("cloud")) {
        image(cloudy, 250, 80 + 75 * i);
      }
      if (cloud.equals("part")) {
        image(partly, 245, 80 + 75 * i);
      }
      if (cloud.equals("snowing")) {
        image(snowy, 250, 85 + 75 * i);
      }
      if (cloud.equals("storms")) {
        image(stormy, 250, 80 + 75 * i);
      }


      text(high + "??", 400, 115 + 75 * i);
      text(low + "??", 500, 115 + 75 * i);
      i++;
    }
  }
}
class ToolsWindow extends PApplet {

  public void settings() {
    size(800, 600);
  }

  public void draw() {
    background(255, 255, 255);
    ellipse(mouseX, mouseY, 20, 20);
  }
}

class NotificationWindow extends PApplet {

  public void settings() {
    size(400, 100);
  }

  public void draw() {
    fill(255);
    rect(0, 0, 400, 100);
    fill(0);

    text("You have a doctors appointment with Dr. Ryan at 5 o'clock today", 10, 50);
  }
}

class LighthWindow extends PApplet {

  public void settings() {
    size(400, 400);

    //color class
    javaColor  = JColorChooser.showDialog(null, "Java Color Chooser", Color.white);
    if (javaColor!=null)
    c = color(javaColor.getRed(), javaColor.getGreen(), javaColor.getBlue());
  }

  public void draw() {
    textSize(50);
    fill(255);
    background(c);
    text("Your New Color", 40, 200);
  }
}

class NewsWindow extends PApplet {

  public void settings() {
    size(300, 150);
  }

  public void draw() {
    background(255);
    fill(0);

    //top
    textSize(20);
    text("Genre", 5, 20);
    text("Show", 120, 20);
    text("Don't Show", 200, 20);
    line(3, 25, 297, 25);

    check.resize(25, 25);
    uncheck.resize(25, 25);

    //rows
    textSize(15);
    text("Politics", 5, 50);
    text("Economics", 5, 80);
    text("Sports", 5, 110);
    text("Technology", 5, 140);

    if (politics) {
      image(check, 130, 30);
      image(uncheck, 230, 30);
    } else {
      image(uncheck, 130, 30);
      image(check, 230, 30);
    }

    if (economics) {
      image(check, 130, 60);
      image(uncheck, 230, 60);
    } else {
      image(uncheck, 130, 60);
      image(check, 230, 60);
    }

    if (sports) {
      image(check, 130, 90);
      image(uncheck, 230, 90);
    } else {
      image(uncheck, 130, 90);
      image(check, 230, 90);
    }

    if (technology) {
      image(check, 130, 120);
      image(uncheck, 230, 120);
    } else {
      image(uncheck, 130, 120);
      image(check, 230, 120);
    }
  }

  public void mouseClicked() {

    //show politics
    if (mouseX >= 130 && mouseX <= 155 && mouseY >= 30 && mouseY <= 55) {
      politics = true;
    }

    //show ecomics
    if (mouseX >= 130 && mouseX <= 155 && mouseY >= 60 && mouseY <= 85) {
      economics = true;
    }

    //show sports
    if (mouseX >= 130 && mouseX <= 155 && mouseY >= 90 && mouseY <= 115) {
      sports = true;
    }

    //show tech
    if (mouseX >= 130 && mouseX <= 155 && mouseY >= 120 && mouseY <= 145) {
      technology = true;
    }

    //hide politics
    if (mouseX >= 230 && mouseX <= 255 && mouseY >= 30 && mouseY <= 55) {
      politics = false;
    }

    //hide ecomics
    if (mouseX >= 230 && mouseX <= 255 && mouseY >= 60 && mouseY <= 85) {
      economics = false;
    }

    //hide sports
    if (mouseX >= 230 && mouseX <= 255 && mouseY >= 90 && mouseY <= 115) {
      sports = false;
    }

    //hide tech
    if (mouseX >= 230 && mouseX <= 255 && mouseY >= 120 && mouseY <= 145) {
      technology = false;
    }
  }
}
