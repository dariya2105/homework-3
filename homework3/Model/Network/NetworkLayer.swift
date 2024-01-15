//
//  NetworkLayer.swift
//  homework3
//
//  Created by Dariya on 14/1/24.
//

import Foundation

struct NetworkService {
    
    enum HTTPMethod: String {
        case GET, POST, PUT, DELETE
    }
    
    private let baseURL = URL(string: "https://dummyjson.com/products")!
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    func fetchProducts(completion: @escaping (Result<[ProductItem], Error>) -> Void) {
        let request = URLRequest(url: baseURL)
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response is: ---------------------------- \n\(response) \n ----------------------------")
            if let error {
                completion(.failure(error))
            }
            if let data {
                do {
                    let products = try decoder.decode(Product.self, from: data).products
                    completion(.success(products))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        urlSession.resume()
    }
    
    func addNewProduct(with product: ProductItem, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            var request =  URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.POST.rawValue
            request.httpBody = try encoder.encode(product)
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                print("Response is: ---------------------------- \n\(response) \n ----------------------------")
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success("Success"))
                }
            }
            urlSession.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateProduct(with product: ProductItem, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let updateProduct = ProductItem(
                id: product.id,
                productTitle: product.productTitle,
                productImage: product.productImage,
                productDescription: product.productDescription
                )
            let url = baseURL.appendingPathComponent("\(product.id)")
            var request =  URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.PUT.rawValue
            request.httpBody = try encoder.encode(updateProduct)
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                print("Response is: ---------------------------- \n\(response) \n ----------------------------")
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success("Products Added"))
                }
            }
            urlSession.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteProduct(with product: ProductItem, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("\(product.id)")
        var request =  URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response is: ---------------------------- \n\(response) \n ----------------------------")
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success("Success"))
            }
        }
        urlSession.resume()
    }
}
