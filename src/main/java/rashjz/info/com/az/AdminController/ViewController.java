/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.AdminController;

import java.io.Serializable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import rashjz.info.com.az.domain.RegistrationForm;

/**
 *
 * @author Azik
 */
@Controller
@RequestMapping("/admin")
public class ViewController implements Serializable{
    
    private static final Logger logger = LoggerFactory.getLogger(ViewController.class.getName());
    
    @RequestMapping(value = "/indexAdmin", method = RequestMethod.GET)
    public String getLogin2Page(Model model) {
        
        return "admin/indexAdmin";
    }
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String getCategoryAdminPage(Model model) {
        
        return "admin/test";
    }
}
