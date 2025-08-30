/**
* Name: prueba
* Based on the internal empty template. 
* Author: gamaa
* Tags: 
*/


model infecciones

global{
	//shape_file blocks_shp <- shape_file("../includes/cent/blocks.shp");
	shape_file blocks_shp <- shape_file("../includes/gdl/manzanas.shp");
	shape_file roads_shp <- shape_file("../includes/cent/roads.shp");
	geometry shape <- envelope(blocks_shp);
	int pob_max <- 0;
	init{	
		create blocks from:blocks_shp with:[poblacion::int(read('POBTOT'))];
		pob_max <- max(blocks collect(each.poblacion));
	}
}
species blocks{
	int poblacion;
	float densidad;
	aspect default{
		densidad <- poblacion/pob_max;
		/*densidad <- densidad<0.75?0.0:densidad-0.75;
		densidad <- densidad / 300;
		densidad <- densidad * 1000;*/
		draw shape color:rgb(255*densidad,255*(1-densidad),densidad);
	}
}

experiment principal type:gui{
	output{
		display simulacion type:opengl background:#black{
			species blocks;
		}
	}
}