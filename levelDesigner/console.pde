float displaySeconds;
float seconds;
String consoleMessage;
void console(String message, float howManySeconds){
    consoleMessage = message;
    displaySeconds = seconds + howManySeconds;
}

void renderconsole(){
    seconds += 1/frameRate;
    // println (seconds);
    if (seconds <= displaySeconds){
        fill(0);
        textSize(32);
        text(consoleMessage, 10, 30);
    }
}
