import win32print
import win32ui
import time
import win32com.client
import imapclient
import os
import email
import datetime
import sys
from PIL import Image, ImageWin, ImageFont, ImageDraw
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

#Add comments and error handler/ documentation on one note / upload to bitbucket

#Using IMAP to read emails temporarily until I can read from the database where the photos will be stored via query
imapObj = imapclient.IMAPClient('imap.gmail.com', ssl=True)
imapObj.login('*********@gmail.com', '********')

#This class is part of the observer and what is called when that exception is thrown
class myhandler(FileSystemEventHandler):
    def on_modified(self, event):
        
        #Opens the path of the modified event which will be the photo entering the repository and opens the file containing the text
        fn = event.src_path
        f = Path("temp.txt")

        #Stores the raw information in a string variable
        tinfo = f.read_text()
        tinfo = tinfo.replace("Name ", "")
        tinfo = tinfo.replace("Company ", "")
        tinfo = tinfo.replace("Select An ID Type ", "")
        tinfo = tinfo.replace("Date range ", "")

        #Creates an array filled with the information stroed in the email. 
        info = tinfo.split("\n\n")

        #Takes the current date and time
        curtime = datetime.datetime.now()

        #If the ID is an employee type than the expiration date is based on 1 year from todays date
        if (info[2] != 'Employee'):
            DL = info[2][0:10].replace('/', '')
            exp = info[2][13:].replace('/', '') 
            DL =  "DL: " + DL[4:8] + DL[0:2] + DL[2:4] 
            exp = "Expires: " + exp[4:8] + '-' + exp[0:2] + '-' + exp[2:4]
        #otherwise that information is stored in the info array
        else:
            DL =  "DL: " + str(curtime.year) + str(curtime.month) + str(curtime.day)  + str(curtime.hour) + str(curtime.minute)
            exp = "Expires: " + str(int(curtime.year) + 1) + '-' + str(curtime.month) + '-' + str(curtime.day)
        
        #create the ID file name and sends a message to the python console so we know its printing
        name = info[0] + "_" + str(curtime.year) + str(curtime.month) + str(curtime.day)
        print(f'Printing ID now ' + fn)
        print(info[0] + "\n" + info[1] + "\n" + DL + "\n" + exp + "\n\n")
        
        #Takes the  image rotates its and adjusts it to be the right size to fit on the template
        pic = Image.open(fn)
        pic = pic.transpose(Image.ROTATE_270)
        pic = pic.resize((117, 173))

        #Oepens the template and pasestes the photo on to the template
        template = Image.open('Templates\\' + info[2] +'.png')
        template.paste(pic, (33, 77))

        #Must open the image as a image draw object to add text. Selects the font folder which will be the same on all windows PC's
        tempdraw = ImageDraw.Draw(template)
        fontsfolder = 'C:\\Windows\\Fonts'
        
        #Selects the font and takes the strings stored in the info array and places them on to the ID image
        arialfont = ImageFont.truetype('arial', 16)
        tempdraw.text((177,157), info[0], fill='black', font=arialfont)
        tempdraw.text((177,181), info[1], fill='black', font=arialfont)
        tempdraw.text((177,205), DL, fill='black', font=arialfont)
        tempdraw.text((177,230), exp, fill='black', font=arialfont)

        #the ID its self is rotated in order to make sure the ID prints correctly, then is saved.
        template = template.transpose(Image.ROTATE_90)
        template.save('IDs\\'+ name + ".png")

        #This entire section is responsible for printing the image generated above
        HORZRES =  8
        VERTRES = 10

        LOGPIXELSX = 88
        LOGPIXELSY = 90

        PHYSICALWIDTH = 110
        PHYSICALHEIGHT = 111

        PHYSICALOFFSETX = 112
        PHYSICALOFFSETY = 113

        printer_name = win32print.GetDefaultPrinter ()
        file_name = "IDs\\" + name + ".png"

        hDC = win32ui.CreateDC ()
        hDC.CreatePrinterDC (printer_name)
        printable_area = hDC.GetDeviceCaps (HORZRES), hDC.GetDeviceCaps (VERTRES)
        printer_size = hDC.GetDeviceCaps (PHYSICALWIDTH), hDC.GetDeviceCaps (PHYSICALHEIGHT)
        printer_margins = hDC.GetDeviceCaps (PHYSICALOFFSETX), hDC.GetDeviceCaps (PHYSICALOFFSETY)

        bmp = Image.open (file_name)
        if bmp.size[0] > bmp.size[1]:
          bmp = bmp.rotate (90)

        ratios = [1.0 * printable_area[0] / bmp.size[0], 1.0 * printable_area[1] / bmp.size[1]]
        scale = min (ratios)

        hDC.StartDoc (file_name)
        hDC.StartPage ()

        dib = ImageWin.Dib (bmp)
        scaled_width, scaled_height = [int (scale * i) for i in bmp.size]
        x1 = int ((printer_size[0] - scaled_width) / 2)
        y1 = int ((printer_size[1] - scaled_height) / 2)
        x2 = x1 + scaled_width
        y2 = y1 + scaled_height
        dib.draw (hDC.GetHandleOutput (), (x1, y1, x2, y2))

        hDC.EndPage ()
        hDC.EndDoc ()
        hDC.DeleteDC ()
        os.remove("temp.txt")
        os.remove(fn)


#goes thorough the message body and extracts text
def get_body(msg):
    if msg.is_multipart():
        return get_body(msg.get_payload(0))
    else: 
        return msg.get_payload(None, True)

#goes through the message body and extracts attachemnets found on the email
def get_attachments(msg):
    for part in msg.walk():
        if part.get_content_maintype() == 'multipart':
            continue

        if part.get('Content-Disposition') is None: 
            continue  

        file_name = part.get_filename() 

        if bool(file_name):  
            file_path = 'Photos\\' + file_name
            with open(file_path, 'wb') as f:  
                f.write(part.get_payload(decode=True))  

if __name__ == "__main__":
    #This is responsible for the observer file imported from the watchdog library
    event_handler = myhandler()
    observer = Observer()
    observer.schedule(event_handler, ".\photos", recursive=False)

    observer.start()
try:
    try:
        while True:
            #This will occur while the the repository remains unmodifed
            time.sleep(1)
            imapObj.select_folder('INBOX', readonly=False)
            #searches for any emails from this source, returns email ID's
            mailID = imapObj.search(['FROM', 'acm.itselectron@gmail.com'])

            #checks to see if the mailID array is empty or not 
            if (mailID != []):
               response = imapObj.fetch(mailID, ['FLAGS', 'BODY', 'RFC822.SIZE', 'ENVELOPE', 'RFC822'])

               for msgid, data in response.items(): 
                    raw = email.message_from_bytes(data[b'RFC822'])  
                    nameinfo = get_body(raw)
                    f = Path("temp.txt")
                    f.write_text(nameinfo.decode("utf-8"))

                    for UID in mailID:
                        imapObj.delete_messages([UID])

                    get_attachments(raw)
                    

    except KeyboardInterrupt:
        observer.stop()
    observer.join()
#error handler to print the error on the console
except:
    Print("Unexpected Error:", sys.exc_info()[0])
    raise
