GUIController c;
IFTextField t;
IFLabel l;

void load_interfascia(){

  c = new GUIController(this);
  t = new IFTextField("Text Field", 25, 30);
  l = new IFLabel("", 25, 70);;
  // t.setHeight(200);

  c.add(t);
  c.add(l);

  t.addActionListener(this);

}

void actionPerformed(GUIEvent e) {
  if (e.getMessage().equals("Completed")) {
    l.setLabel(t.getValue());
  }
}
