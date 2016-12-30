/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.AdminController;

import java.io.Serializable;
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
import rashjz.info.com.az.domain.PagingResult;
import rashjz.info.com.az.entity.OrderStatus;
import rashjz.info.com.az.entity.Orders;
import rashjz.info.com.az.entity.Products;
import rashjz.info.com.az.service.OrderService;
import rashjz.info.com.az.service.OrderStatusService;

/**
 *
 * @author Azik
 */
@Controller
@RequestMapping("/admin")
public class OrderController implements Serializable {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class.getName());

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        //  binder.setValidator(customerFormValidator);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));

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
    public String getcheckoutPage(Model model, @ModelAttribute("order") Orders order, Integer offset, Integer maxResults, BindingResult result) {
        if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) {
            return "redirect:/login";

        } else if (result.hasErrors()) {
            System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx " + result.getFieldError().getDefaultMessage());

        } else {
//          
            Map<String, Object> filters = new HashMap<>();
            filters.put("", 0);
            if (result.hasErrors()) {
                System.out.println("xxxxx " + result.getFieldError().getDefaultMessage());
                return "login";
            }
            if (order == null) {
                order = new Orders();
            }
            PagingResult pagingData = new PagingResult();
            if (offset == null) {
                offset = 0;
            }
            if (offset != null) {//new or old
//            filters.put("typeId", "1");
                if (order.getUserId() != null && !order.getUserId().equals("")) {
                    if(order.getUserId().getUsername() != null && !order.getUserId().getUsername().equals("")){
                        System.out.println("           ---------------------------------- 1");
                    filters.put("username", order.getUserId().getUsername());
                    }
                }
                 if (order.getUserId() != null && !order.getUserId().equals("")) {
                    if(order.getUserId().getFirstname() != null && !order.getUserId().getFirstname().equals("")){
                    filters.put("firstname", order.getUserId().getFirstname());
                    }
                 }
                  if (order.getUserId() != null && !order.getUserId().equals("")) {
                    if(order.getUserId().getLastname() != null && !order.getUserId().getLastname().equals("")){
                    filters.put("lastname", order.getUserId().getLastname());
                    }
                  }
                if (order.getProductId() != null && !order.getProductId().equals("")) {
                    filters.put("productId", order.getProductId().getTitle());
                }
                if (order.getCount() != null && !order.getCount().equals("")) {
                    filters.put("count", order.getCount());
                }
                if (order.getStatusId() != null && !order.getStatusId().equals("")) {
                    filters.put("statusId", order.getStatusId().getId());
                }
                if (order.getToDate() != null && !order.getToDate().equals("")) {
                    filters.put("toDate", order.getToDate());
                }
                if (order.getFromDate() != null && !order.getFromDate().equals("")) {
                    filters.put("fromDate", order.getFromDate());
                }
            }
            pagingData = orderService.lazyLoadOrders(offset.intValue(), 10, null, SortOrder.UNSORTED, filters);
            orderService.lazyLoadOrdersCount(offset.intValue(), 10, null, SortOrder.UNSORTED, filters, pagingData);
            model.addAttribute("orderList", pagingData.getList());
            model.addAttribute("count", pagingData.getTotalResult());
            model.addAttribute("orderadmin", order);
            model.addAttribute("offset", offset);
        }
        return "admin/orderAdmin";
    }

    @RequestMapping(value = "viewOrder/{id}", method = RequestMethod.GET)
    public String viewOrder(@PathVariable("id") Integer id, Model model) {
        Orders order = new Orders();
        order = orderService.getByKey(id);
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
        Orders orders = orderService.getByKey(Id);
        model.addAttribute("order", orders);
        return "admin/editOrder";

    }

    @RequestMapping(value = "order/{id}/delete", method = RequestMethod.GET)
    public String getOrder(@PathVariable("id") Integer id,
            final RedirectAttributes redirectAttributes) {
        logger.info("deleteCustomers() : {}" + id);
        Orders orders = orderService.getByKey(id);
        orderService.delete(orders);
        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Order is deleted!");
        return "redirect:/admin/checkoutList";

    }

}
