

import java.awt.Component;
import java.awt.Graphics;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.image.BufferedImage;
import java.awt.Color;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import javax.imageio.ImageIO;

public class JavaWalkBufferedImageTest1 extends Component {

	public static String output="";

  public static void main(String[] foo) throws IOException {
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
				BufferedImage image = ImageIO.read(file);
				int w = image.getWidth();
			    int h = image.getHeight();
			    System.out.println("width, height: " + w + ", " + h);

			    int index=0;
			    for (int i = 0; i < h; i++)
			    {
			      for (int j = 0; j < w; j++, index++)
			      {
			        //System.out.println("x,y: " + j + ", " + i);

			        int pixel = image.getRGB(j, i);

			        output+= getHex(pixel);
			        if(index % 128 == 0 && index > 127)
			        {
			        	output+="|";
			        }


			      }
			    }


			} catch (IOException e1) {
				e1.printStackTrace();
			}

			System.out.println("Done.\n");
			System.out.println(output.substring(0, output.length()-1));

			File out = new File(System.getProperty("user.home")+"/Desktop/delete");
			BufferedWriter writer = new BufferedWriter(new FileWriter(System.getProperty("user.home")+"/delete"));
		    writer.write(output.substring(0,output.length()));

		    writer.close();
		}


  public static String getHex(int pixel)
  {
	  int alpha = (pixel >> 24) & 0xff;
	  int red = (pixel >> 16) & 0xff;
	  int green = (pixel >> 8) & 0xff;
	  int blue = (pixel) & 0xff;
	  Color color = new Color(red ,green, blue);
	  String hex = Integer.toHexString(color.getRGB() & 0xffffff);
	  if (hex.length() < 6) {
	      hex = "0" + hex;
	  }
	  return hex;
  }



}