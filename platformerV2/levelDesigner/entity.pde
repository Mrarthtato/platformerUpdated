//TODO make entity menu list

entity[] entity_types = {
    new text("sign", 0, 0, "message inside this box"),
    // new mob("doggo", 0, 0)

};
entity[] entity_list = {
    new text("sign", 5, 10, "message inside this box"),
    new mob("doggo", 30, 10),
    // new entity("watever", 5, 40),

};
interface behaviour{
    void render();
}
class entity {
    String name;
    float posx, posy;

    entity(String name, float posx, float posy){
        this.name = name;
        this.posx = posx;
        this.posy = posy;
    }

    void render(){
        fill(color(0,0,255));
        cube(posx, posy);
    }
    
}
class text extends entity implements behaviour{
    String message;

    text(String name, float posx, float posy,String message){
        super(name, posx, posy);
        this.message = message;
    }
    void render(){
        fill(color(0,0,255));
        make_block(posx, posy);
    }
}
class mob extends entity implements behaviour{
    mob(String name, float posx, float posy){
        super(name, posx, posy);
    }
    void render(){
        fill(color(0,255,255));
        make_block(posx, posy);
    }
}
