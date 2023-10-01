from PIL import Image

def make_background_transparent(img_path, output_path):
    img = Image.open(img_path).convert("RGBA")

    datas = img.getdata()

    new_data = []
    for item in datas:
        # Change all black (also shades of blacks)
        # pixels to transparent
        if item[0] == 0 and item[1] == 0 and item[2] == 0:
            new_data.append((0, 0, 0, 0))
        else:
            new_data.append(item)

    img.putdata(new_data)
    img.save(output_path, "PNG")

def resize_image(input_path, output_path, scale_factor=0.5):
    img = Image.open(input_path)
    width, height = img.size
    img = img.resize((int(width * scale_factor), int(height * scale_factor)), Image.LANCZOS)
    img.save(output_path)


resize_image('zundastanding.png', 'resized_image_path.png')
# Example usage:
#make_background_transparent('zundastanding.png', 'output_image_path.png')

