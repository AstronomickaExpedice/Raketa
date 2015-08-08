prumerVenk = 25;
Vyska = 50;
Stena = 3;
Okrouzek = 28;
OkrouzekH = 2;
KulickaOdOkraje = 12;



module puntik(x, y, z, r)
{
	translate([x, y, z]) {
		sphere(r=r);
	}
}

module obrys(){
	cylinder(h=Vyska, r=prumerVenk);
	puntik((prumerVenk-4.5), 0, KulickaOdOkraje, 7.5);
	puntik(-(prumerVenk-4.5), 0, KulickaOdOkraje, 7.5);
	puntik((prumerVenk-4.5), 0, Vyska-KulickaOdOkraje, 7.5);
	puntik(-(prumerVenk-4.5), 0, Vyska-KulickaOdOkraje, 7.5);

	translate([0, 0, ((Vyska/2) - (OkrouzekH/2))]) {
		cylinder(h=OkrouzekH, r=Okrouzek);
	}
}

module Adapter()
{
	difference(){
		obrys();
		translate([0, 0, -1]) {
			cylinder(h=Vyska+2, r=(prumerVenk-Stena));
		}
	}
}

Adapter();

