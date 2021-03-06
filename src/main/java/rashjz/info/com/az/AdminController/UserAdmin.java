/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.AdminController;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.swing.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import rashjz.info.com.az.domain.PagingResult;
import rashjz.info.com.az.entity.Faq;
import rashjz.info.com.az.entity.Users;
import rashjz.info.com.az.service.UserService;

/**
 *
 * @author Azik
 */
@Controller
@RequestMapping("/admin")
public class UserAdmin implements Serializable{
    
    private static final Logger logger = LoggerFactory.getLogger(UserAdmin.class.getName());
    
    @Autowired
    UserService userService;
    
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        //  binder.setValidator(customerFormValidator);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss.S");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }
    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String getUsersAll(Model model, @ModelAttribute("users") Users users, Integer offset, Integer maxResults){
        Map<String, Object> filters = new HashMap<>();
         filters.put("", 0);
        if (users == null) {
            users = new Users();
        }
        PagingResult pagingData = new PagingResult();
        if (offset == null) {
            offset = 0;
            filters.put("enabled", 1);
        }
        if (offset != null) {//new or old
//            filters.put("typeId", "1");
            if (users.getUsername() != null && !users.getUsername().equals("")) {
                filters.put("username", users.getUsername());
            }
            if (users.getFirstname() != null && !users.getFirstname().equals("")) {
                filters.put("firstname", users.getFirstname());
            }
            if (users.getLastname() != null && !users.getLastname() .equals("")) {
                filters.put("lastname", users.getLastname());
            }
            if (users.getPhone() != null && !users.getPhone().equals("")) {
                filters.put("phone", users.getPhone());
            }
            if (users.getEnabled() !=0) {
                filters.put("enabled", users.getEnabled());
            }
        }
        pagingData = userService.lazyLoadUsers(offset.intValue(), 10, null, SortOrder.UNSORTED, filters);
        userService.lazyLoadUsersCount(offset.intValue(), 10, null, SortOrder.UNSORTED, filters, pagingData);
        List<Users> listUser=userService.getAllUser();
        model.addAttribute("usersList", pagingData.getList());
        model.addAttribute("count", pagingData.getTotalResult());
        model.addAttribute("users", users);
        model.addAttribute("offset", offset);
        return "admin/usersAdmin";
    }
    
    @RequestMapping(value = "/edituser", method = RequestMethod.POST)
    public String UpdateUser(@ModelAttribute("user") Users users, BindingResult result, Model model, final RedirectAttributes redirectAttributes
    ) {
        logger.info("Update-User - - - " + users.toString());
        if (result.hasErrors()) {
            logger.info("Update-User- - - " + result.toString());
            return "403";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
                redirectAttributes.addFlashAttribute("msg", "User updated successfully!");
      
            userService.update(users);

            return "redirect:/admin/editUser/" + users.getUserId();
        }
    }
    
    @RequestMapping(value = "editUser/{id}", method = RequestMethod.GET)
    public String EditUser(@PathVariable("id") int Id, Model model
    ) {

        logger.debug("showUser id: {}", Id);
        Users users= userService.getByKey(Id);
        
        System.out.println("showCustomers xxxxxxxxxxxxx" + users.toString());

        model.addAttribute("user", users);

        return "admin/editUser";

    }
    
    @RequestMapping(value = "user/{id}/delete", method = RequestMethod.GET)
    public String getDelete(@PathVariable("id") Integer id,
            final RedirectAttributes redirectAttributes) {
        logger.info("deleteUsers() : {}" + id);
        Users users= userService.getByKey(id);
        userService.delete(users);
        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Users is deleted!");
        return "redirect:/admin/users";

    }
    
    
}
