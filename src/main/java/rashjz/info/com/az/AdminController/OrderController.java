/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.AdminController;


import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import rashjz.info.com.az.entity.OrderStatus;
import rashjz.info.com.az.entity.Orders;
import rashjz.info.com.az.service.OrderService;
import rashjz.info.com.az.service.OrderStatusService;

/**
 *
 * @author Azik
 */
@Controller
@RequestMapping("/admin")
public class OrderController implements Serializable{
     private static final Logger logger = LoggerFactory.getLogger(OrderController.class.getName());
     
     @InitBinder
    protected void initBinder(WebDataBinder binder) {
        //  binder.setValidator(customerFormValidator);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
        
    }
    
     @Autowired
     OrderService orderService;
     
     @Autowired
     OrderStatusService orderStatusService;
     
    @ModelAttribute("statusList")
    public List<OrderStatus> populateLocList() {
        List<OrderStatus> list = orderStatusService.getAll(OrderStatus.class);
        return list;
    }
     
     @RequestMapping(value = "/checkoutList", method = RequestMethod.GET)
     public String getcheckoutPage(Model model,@RequestParam(value = "typeId", required = false) Integer typeId) {
        if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) {
            return "redirect:/login";
        } else {
            if (typeId==null) {
                typeId=3;//standart sebet
            }
//            Users entity = AuthoritiesConverter.getUserObject().getUsers();
            List<Orders> orders = orderService.getByStatusType(typeId);
          
            if (orders != null) {
                model.addAttribute("total", orders.size());
                
            } else {
                model.addAttribute("total", 0);
            }
            model.addAttribute("typeId",typeId);
            model.addAttribute("orders", orders);
        }
        return "admin/orderAdmin";
    }
     
      @RequestMapping(value = "viewOrder/{id}", method = RequestMethod.GET)
      public String viewOrder(@PathVariable("id") Integer id,Model model){
          Orders order=new Orders();
          order=orderService.getByKey(id);
          model.addAttribute("order", order);
          return "admin/viewOrder";
      }
      
      @RequestMapping(value = "/editOrder", method = RequestMethod.POST)
    public String UpdateOrder(@ModelAttribute("order") Orders orders, BindingResult result, Model model, final RedirectAttributes redirectAttributes
    ) { 
       
        //orders.setStatusId(convert.convert(result.getModel("",));
        logger.info("save-Or-Update-Order - - - " + orders.toString());
        if (result.hasErrors()) {
            System.out.println("save-Or-Update-Order - - - " + result.toString());
            logger.info("save-Or-Update-Order - - - " + result.toString());
            return "403";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
                redirectAttributes.addFlashAttribute("msg", "Order updated successfully!");
           orderService.update(orders);

            return "redirect:/admin/editOrder/" + orders.getId();
        }
    }
    @RequestMapping(value = "editOrder/{id}", method = RequestMethod.GET)
    public String EditOrder(@PathVariable("id") int Id, Model model
    ) {

        logger.debug("showBrand id: {}", Id);
        Orders orders= orderService.getByKey(Id);
        model.addAttribute("order", orders);
        return "admin/editOrder";

    }
    
    @RequestMapping(value = "order/{id}/delete", method = RequestMethod.GET)
    public String getOrder(@PathVariable("id") Integer id,
            final RedirectAttributes redirectAttributes) {
        logger.info("deleteCustomers() : {}" + id);
        Orders orders= orderService.getByKey(id);
        orderService.delete(orders);
        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Order is deleted!");
        return "redirect:/admin/checkoutList";

    }
    
}
