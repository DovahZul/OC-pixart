
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.image.BufferedImage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Printer {

	static final String hex = "0123456789abcdef";
	static String output = "";
	static void print(int x, int y, int c, int l){
		output+=new String(new char[]{
				hex.charAt(x),
				hex.charAt(16-y-l),
				hex.charAt(l-1),
				hex.charAt((c>>20)&15),
				hex.charAt((c>>16)&15),
				hex.charAt((c>>12)&15),
				hex.charAt((c>>8)&15),
				hex.charAt((c>>4)&15),
				hex.charAt((c)&15)
		});
	}

	public static void main(String[] args) throws IOException{
		String name=null, ttt=null;

		File file = new File(System.getProperty("user.home")+"/toprint.jpg");
		if(!file.exists()){
			String other = file.getAbsolutePath();
			file = new File(file.getParentFile(), "toprint.jpg");
			if(!file.exists()){
				System.out.println("I couldn't find your image file! Please copy it there: "+other+"/.jpg");
				System.exit(0);
			}
		}

		try {
			BufferedImage raw = ImageIO.read(file);
			int w = (raw.getWidth()+15)&0xfffff0, h = (raw.getHeight()+15)&0xfffff0;

			BufferedImage img;
			if(w==raw.getWidth() && h==raw.getHeight()){
				img = raw;
			} else {
				img = new BufferedImage(w, h, 2);
				Graphics g = img.getGraphics();
				g.setColor(new Color(0,0,0,0));
				g.fillRect(0, 0, w, h);
				g.drawImage(raw, (w-raw.getWidth())/2, (h-raw.getHeight())/2, raw.getWidth(), raw.getHeight(), null);
				g.dispose();
			}

			int mode = 1;
			//System.out.println("1:lossless format(1:1)  2:lossy format(1:2)");
			//mode = System.in.read();


					switch(mode)
					{

						case(1):
						{
							System.out.println("Resolution: "+h+"x"+w+" pixels.");
							System.out.println((w/16)+":"+(h/16)+" blocks, totally "+ (w/16)*(h/16));
							output+=String.valueOf(w/16)+":"+String.valueOf(h/16)+"|";
							for(int i=0; i<w; i+=16)
							{
								for(int j=0; j<h; j+=16)
								{
									partLossless(name, ttt, img, i, j);
									output+="+";
								}
							}

						break;
						}
						case(2):
						{
							System.out.println("Resolution: "+h+"x"+w+" pixels.");
							System.out.println((w/8)+":"+(h/8)+" blocks, totally "+ (w/8)*(h/8));
							output+=String.valueOf(w/8)+":"+String.valueOf(h/8)+"|";
							for(int i=0; i<w; i+=8)
							{
								for(int j=0; j<h; j+=8)
								{
									partLossless(name, ttt, img, i, j);
									output+="+";
								}
							}

						break;
						}
						case(3):
						{
							for(int i=0;i<w;i+=16)
							{
								for(int j=0;j<h;j+=16)
								{
									part(name, ttt, img, i, j);
									output+="+";
								}
							}

						break;


						}
					}

		} catch (IOException e1) {
			e1.printStackTrace();
		}

		//Toolkit.getDefaultToolkit().getSystemClipboard().setContents(new StringSelection(output.substring(0, output.length()-1)), null);
		System.out.println("Done, you can insert it now into a file and then print it :) \n");
		System.out.println(output.substring(0, output.length()-1));

		File out = new File("../output");
		BufferedWriter writer = new BufferedWriter(new FileWriter("output"));
	    writer.write(output.substring(0,output.length()));

	    writer.close();
	}

	static void partLossless(String name, String ttt, BufferedImage img, int sx, int sy){
		int that, same = 0;
		for(int i=0;i<16;i++){
			for(int j=0;j<16;){
				that = img.getRGB(i+sx, j+sy);
				if(((that>>24)&255)>220){
					same = 1;while(j+same<16 && same(img.getRGB(i+sx, j+sy+same), that)){same++;}
					print(i, j, that, same);
					j += same;
				} else j++;
			}
		}
	}


	/*
	 static void partLossless FOR 128 !!!!!(String name, String ttt, BufferedImage img, int sx, int sy){
		int that, same = 0;
		for(int i=0;i<16;i+=+){
			for(int j=0;j<16;j+=2){
				that = img.getRGB(i/2+sx, j/2+sy);
				//if(((that>>24)&255)>220){
					//same = 1;while(j+same<16 && same(img.getRGB(i+sx, j+sy+same), that)){same++;}
					print(i, j, that, 0);
				//	j += same;
				//} else
					//j++;
			}
		}
	}
	 */
	static void part(String name, String ttt, BufferedImage img, int sx, int sy){
		int that, same = 0;
		for(int i=0;i<16;i+=2){
			for(int j=0;j<16;j+=2){
				that = img.getRGB(i+sx, j+sy);
				//if(((that>>24)&255)>220){
					//same = 1;while(j+same<8 && same(img.getRGB(i+sx, j+sy+same), that)){same++;}
					print(i, j, that, 0);
					//j += same;
			//	} else
				//	j++;
			}
		}
	}

	static int abs(int i){return i<0?-i:i;}
	static int a(int rgb){return (rgb>>24)&255;}
	static int r(int rgb){return (rgb>>16)&255;}
	static int g(int rgb){return (rgb>>8)&255;}
	static int b(int rgb){return rgb&255;}

	static boolean same(int c1, int c2){
		return a(c1)>220 && abs(r(c1)-r(c2))<30 && abs(g(c1)-g(c2))<20 && abs(b(c1)-b(c2))<50;
	}
}