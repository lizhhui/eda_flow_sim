# kkk=dict()
# for kk in kkk
# for kk in kkk.keys()
# for kk in kkk.values()
# for key ,value in kkk.items()
# len(kkk)


from Tkinter import *
import time
import os
import subprocess
import xml.etree.ElementTree as etree


class Application(Frame):
    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.grid()

        #self.stage  = IntVar()
        self.sel_glo = IntVar()
        self.sel_glo.set(1)
        self.stage  = StringVar()
        self.stage.set('syn')
        self.editor = StringVar()
        self.editor.set('vim')
        self.cmd = StringVar()
        self.collect_conf()

        self.master.geometry('800x800')
        self.createWidgets()
        self.update_xml_reg = self.register(self.update_xml)
        # grid layout -------------
        #self.sub_pack()
        #self.fme_top.bind("<Configure>", self.onFrameConfigure)
        self.cav_top.bind("<Configure>", self.frameautofill)
        self.f_1.bind("<Configure>", self.funscl_f_1)
        self.f0.grid_columnconfigure(0,weight=1,uniform="fred")
        self.f0.grid_columnconfigure(1,weight=1,uniform="fred")
        self.f0.grid_columnconfigure(2,weight=1,uniform="fred")
        #self.f_1.grid_columnconfigure(0,weight=1,uniform="fred")
        self.f_1.grid_columnconfigure(1,weight=1,uniform="fred")
        self.f_1.grid_columnconfigure(2,weight=1,uniform="fred")
        self.f2.grid_columnconfigure(0,weight=1,uniform="fred")
        self.f2.grid_columnconfigure(1,weight=1,uniform="fred")
        self.f2.grid_columnconfigure(2,weight=1,uniform="fred")
        # ======================


    def createWidgets(self):
        self.cav_top=Canvas(self.master,bg="blue")
        self.fme_top=Frame(self.cav_top)
        self.cav_top.create_window((0,0),window=self.fme_top,anchor="nw", tags="self.frame")
        # grid layout -------------
        self.cav_top.pack(side="left",fill="both",expand=True)
        self.fme_top.pack()
        # ======================
        self.f0  = Frame(self.fme_top)
        self.f0.grid  (row=0,column=0)
        #self.f_1 = LabelFrame(self.f0,bg="gray",text='Configurations')
        #self.f_1.grid (row=0,column=1)
        self.scroll_labelframe('f_1','Configurations','f0')
        self.f1  = Frame(self.fme_top)
        self.f1.grid  (row=1,column=0,columnspan=9 ,sticky=W+E)
        self.f2  = Frame(self.fme_top)
        self.f2.grid  (row=2,column=0,columnspan=9 ,sticky=W+E)
        # grid layout -------------
        # ======================
        self.new_create_label_00 = Label(self.f0,text='Select flow below:')
        self.new_create_label_00.grid(row=0 ,column=0,sticky=W)
        i=1
        for flow in sort(self.conf_flow):
            temp="f0_radio_"+flow
            self.__dict__[temp] = Radiobutton(self.f0,variable=self.stage,command=self.sel_stage, value=flow , text=flow)
            self.__dict__[temp].grid(row=i ,column=0,sticky=W)
            i+=1
        self.occu_r00 =Entry(self.f0, textvariable=self.cmd)
        self.occu_r01 =Entry(self.f2)
        self.occu_r00.grid(row=i,column=0)
        self.occu_r01.grid(row=0,column=0)
        # grid layout -------------
        # ======================
        self.f1_button_00 = Button(self.f1, text='Quit', command=self.lzh_exec)
        self.f1_button_01 = Button(self.f1, text='Mission Launch', command=self.mission_launch)
        self.f1_radio_12  = Radiobutton(self.f1,variable=self.editor,command=self.sel_editor, value='emacs', text='emacs'    )
        self.f1_radio_13  = Radiobutton(self.f1,variable=self.editor,command=self.sel_editor, value='vim',   text='vim'    )
        self.f1_check_04  = Checkbutton(self.f1,variable=self.sel_glo,text='global'   )
        # grid layout -------------
        self.f1_button_00.grid(row=0,column=0,sticky=W) 
        self.f1_button_01.grid(row=0,column=1,sticky=W) 
        self.f1_radio_12.grid(row=0,column=2,sticky=W) 
        self.f1_radio_13.grid(row=0,column=3,sticky=W) 
        self.f1_check_04.grid(row=0,column=4,sticky=W) 
        # ======================
        self.new_create_text = Text(self.f2,bg="gray")
        self.scl             = Scrollbar(self.f2,orient=VERTICAL,command=self.new_create_text.yview)
        # grid layout -------------
        self.new_create_text.grid(row=1,column=0,columnspan=3,sticky=W+N)
        self.scl.grid(row=1,column=4,sticky=N+S+W)
        # ======================
        self.new_create_text['yscrollcommand']=self.scl.set

    def sel_editor(self):
        self.new_create_text.insert('1.0',"editor set to " + self.editor.get()+"\n")

    def onFrameConfigure(self, event):
        pass
        #self.cav_top.configure(scrollregion=self.cav_top.bbox("all"))

    def frameautofill(self, event):
        #self.fme_top.configure(width = self.cav_top.winfo_width())
        self.occu_r00.configure(width = self.cav_top.winfo_width()/29)
        self.occu_r01.configure(width = self.cav_top.winfo_width()/29)
        self.new_create_text.configure(width = self.cav_top.winfo_width()/8)
        self.new_create_text.configure(height = (self.cav_top.winfo_height()-400)/16)
        
        #print "-----"
        #print self.fme_top.winfo_width()
        #print self.cav_top.winfo_width()

    def scroll_labelframe(self, name , txt, prnt):
        cav_name="cav_"+name
        scl_name="scl_"+name
        self.__dict__[cav_name] = Canvas(self.f0,bg="red")
        self.__dict__[cav_name].grid(row=0,column=1,columnspan=2,rowspan=100,sticky=N+S+E+W)
        self.__dict__[name] = LabelFrame(self.__dict__[cav_name],text="Configurations:",bg="gray",bd=4)
        self.__dict__[cav_name].create_window((0,0),window=self.__dict__[name],anchor='nw')
        
        self.__dict__[scl_name] = Scrollbar(self.f0,orient="vertical",command=self.cav_f_1.yview)
        self.__dict__[cav_name].configure(yscrollcommand=self.scl_f_1.set)
        self.__dict__[scl_name].grid(row=0,column=3,rowspan=100,sticky=S+N+E)
               
    def funscl_f_1(self,event):
        self.cav_f_1.configure(scrollregion=self.cav_f_1.bbox("all"))
        #self.cav_f_1.configure(scrollregion=(0,0,0,self.cav_f_1.winfo_height()))
        #print "-----"
        #print self.f0.winfo_height()
        #print self.cav_f_1.winfo_height()

    def lzh_exec(self):
        self.quit()

    def loop_check(self,p,num):
        self.new_create_text.insert(END,num) 
        if p.poll() is None:
            line = p.stdout.readline()
            self.new_create_text.insert(END,line) 
            self.new_create_text.after(3000,self.loop_check,p,"not over\n")
        else :
            self.new_create_text.insert(END,"over!!!\n") 
    
    def mission_launch(self):
            #a=os.popen('/Applications/Emacs.app/Contents/MacOS/Emacs &').read()
            #self.new_create_text.insert('1.0',a)
            p=subprocess.Popen(self.conf_flow[self.stage.get()]['attri']['cmd'],shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT) 
            self.new_create_text.insert(END,p.stdout.readline())
            #self.new_create_text.insert(1.0,p.stdout.readline())
            self.new_create_text.after(3000,self.loop_check,p,"go into loop\n")

            
    def collect_conf(self):
        # tag text attrib
        self.file = etree.parse(os.path.abspath("lll.xml"))
        self.layout = self.file.getroot()
        for child in self.layout:
            if child.tag == "global":
                self.conf_global=self.traverse_list(child)
            elif child.tag == "flow":
                self.conf_flow =dict()
                for kk in child:
                    temp=dict()
                    temp["child"] = self.traverse_list(kk)
                    temp["attri"] = kk.attrib
                    self.conf_flow[kk.tag] =temp

    def traverse_list(self, element):
        hash=dict();
        if len(element) >0:
            for child in element:
                hash[child.tag] = child.text
        return hash

            
    
    def remove_widgets(self):
        for w in self.f_1.grid_slaves() :
            w.grid_forget() 

    def sel_stage(self):
        ttt="select " + str(self.stage.get()) +"\n"
        self.new_create_text.insert(END,ttt)
        self.cmd.set(self.conf_flow[self.stage.get()]['attri']['cmd'])

        self.remove_widgets()

        i=0
        if(self.sel_glo.get()):
            for kk in self.conf_global:
                temp="global_conf_label_"+kk
                self.__dict__[temp] = Label(self.f_1, text=kk)
                self.__dict__[temp].grid(row=i,column=1,sticky=E)
                
                temp="global_conf_entry_"+kk
                xpath = "global/" + kk 
                self.__dict__[temp] = Entry(self.f_1,validate='focusout',validatecommand=(self.update_xml_reg,temp,xpath,'%P',''))
                self.__dict__[temp].insert(0,self.conf_global[kk])
                self.__dict__[temp].grid(row=i,column=2,sticky=W)
                i=i+1
                
            
        
        for kk in self.conf_flow[self.stage.get()]['child']:
            temp="flow_conf_entry_"+kk
            xpath='flow/'+self.stage.get()+'/'+kk
            self.__dict__[temp] = Entry(self.f_1,validate='focusout',validatecommand=(self.update_xml_reg,temp,xpath,'%s',''))
            self.__dict__[temp].insert(0,self.conf_flow[self.stage.get()]['child'][kk])
            self.__dict__[temp].grid(row=i,column=2,sticky=W)

            temp="flow_conf_label_"+kk
            self.__dict__[temp] = Label(self.f_1, text=kk)
            self.__dict__[temp].grid(row=i,column=1,sticky=E)
            i=i+1
        i=0
        if(len(self.conf_flow[self.stage.get()]['attri']) > 1) :
            for kk in self.conf_flow[self.stage.get()]['attri']:
                if(cmp(kk ,'cmd')) :
                    temp="flow_conf_label_"+kk
                    var ="flow_conf_label_var_"+kk
                    xpath='flow/'+self.stage.get()
                    self.__dict__[var] = IntVar()
                    self.__dict__[var].set(int(self.conf_flow[self.stage.get()]['attri'][kk]))
                    self.__dict__[temp] = Checkbutton(self.f_1,variable=self.__dict__[var], command=(self.update_xml_reg,temp,xpath,var,kk), text=kk)
                    self.__dict__[temp].grid(row=i,column=0,sticky=W)
                    i=i+1

    
    def update_xml(self,name,xml_name,value,attrib):
        print(name)
        print(xml_name)
        print(value)
        print("------")
        if(attrib == ''):
            self.layout.find(xml_name).text=value
            print("is_tttt")
           
        else:
            self.layout.find(xml_name).attrib[attrib]=str(self.__dict__[value].get())
            print("is_aaaa")

        self.file.write("out.xml")
        return False
        
                    

app = Application()
app.master.title('lzh grid')
#app.master.geometry('800x800')
app.mainloop()
