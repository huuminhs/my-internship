import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import reactor.core.publisher.Mono;

@SpringBootApplication
public class WebClientExampleApplication {

    private final WebClient webClient;

    public WebClientExampleApplication() {
        this.webClient = WebClient.create("http://localhost:8080/v1/order");
    }

    public static void main(String[] args) {
        SpringApplication.run(WebClientExampleApplication.class, args);
    }

    @Override
    public void run(String... args) {
        try {
            getOrderById(1);
            createOrder("Minh", 20000f);
            updateOrder(1, "Minh", 80000f);
            deleteOrder(1);
        } catch (WebClientResponseException e) {
            System.err.println("Error response: " + e.getResponseBodyAsString());
        }
    }

    private void getOrderById(int id) {
        webClient.get()
                .uri("/{id}", id)
                .retrieve()
                .bodyToMono(String.class)
                .doOnNext(System.out::println)
                .block();
    }

    private void createOrder(String customer, double value) {
        webClient.post()
                .bodyValue(new OrderRequest(customer, value))
                .retrieve()
                .bodyToMono(String.class)
                .doOnNext(System.out::println)
                .block();
    }

    private void updateOrder(int id, String customer, double value) {
        webClient.put()
                .uri("/{id}", id)
                .bodyValue(new OrderRequest(customer, value))
                .retrieve()
                .bodyToMono(String.class)
                .doOnNext(System.out::println)
                .block();
    }

    private void deleteOrder(int id) {
        webClient.delete()
                .uri("/{id}", id)
                .retrieve()
                .bodyToMono(String.class)
                .doOnNext(System.out::println)
                .block();
    }

    private static class OrderRequest {
        private String customer;
        private double value;

        public OrderRequest(String customer, double value) {
            this.customer = customer;
            this.value = value;
        }

        public String getCustomer() {
            return customer;
        }

        public double getValue() {
            return value;
        }
    }
}
