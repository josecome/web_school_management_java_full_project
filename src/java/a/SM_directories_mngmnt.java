/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import java.io.File;
import java.io.IOException;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Admin
 */
public class SM_directories_mngmnt {

    public void deleteAllfiles() {
        File folder = new File(SM_Strngs.fl);
        File[] listOfFiles = folder.listFiles();
        try {
            for (int i = 0; i < listOfFiles.length; i++) {
                File fld = new File(SM_Strngs.fl + File.separator + listOfFiles[i].getName());
                try {
                    fld.delete();
                } catch (Exception e) {
                }
            }
        } catch (Exception e) {
        }
        try {
            File directory = new File(SM_Strngs.fl);
            if (!directory.exists()) {
                directory.mkdir();
            }
        } catch (Exception ex) {
        }
    }

    public void cpybckflToCFloldr(String vlsgetpath) {
        File source = new File(vlsgetpath + "\\webapps\\SM\\BCKUPS");
        File dest = new File("C:\\SM\\BCKUPS");
        try {
            FileUtils.copyDirectory(source, dest);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void creatTmpFldr() {
        try {
            File directory = new File("c:\\temp");
            if (!directory.exists()) {
                directory.mkdir();
            }
        } catch (Exception e) {
        }
    }

    public void checkIfDrctyExistandCreateIt(String vlsgetpath) {
        for (String f : "\\webapps\\SM\\BCKUPS,\\webapps\\SM\\TEMPPATH,C:\\SM\\BCKUPS,C:\\SM\\TEMPPATH,C:\\SM\\SOURF".split(",")) {
            if (f == null || f.trim().length() == 0) {
            } else {
                try {
                    //System.out.println("V: " + vlsgetpath + f);
                    String fpth;
                    if (f.equalsIgnoreCase("C:\\SM\\BCKUPS") || f.equalsIgnoreCase("C:\\SM\\TEMPPATH") || f.equalsIgnoreCase("C:\\SM\\SOURF")) {
                        fpth = f;
                        //System.out.println("V: " + fpth);
                    } else {
                        fpth = vlsgetpath + f;
                        //System.out.println("V: " + fpth);
                    }
                    File directory = new File(fpth);
                    if (!directory.exists()) {
                        directory.mkdirs();
                    } else {
                        if (!f.equalsIgnoreCase("C:\\SM\\BCKUPS") && f.equalsIgnoreCase("C:\\SM\\TEMPPATH")) {
                            deleteAllfiles();
                        }
                    }
                } catch (Exception e) {
                    //System.out.println("E:" + e.getMessage());
                }
            }
        }
    }

    public void creatDBFolder() {
        try {
            File directory = new File(SM_Strngs.dbfolder);
            if (!directory.exists()) {
                directory.mkdir();
            }
        } catch (Exception e) {
        }
    }
}
