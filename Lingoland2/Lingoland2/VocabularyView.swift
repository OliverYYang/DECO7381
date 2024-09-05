//
//  VocabularyView.swift
//  Lingoland2
//
//  Created by 杨小洲 on 2024/8/28.
//

import Foundation

import SwiftUI

struct VocabularyView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search...", text: .constant(""))
                        .padding(.leading, 10)
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 10)
                }
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tank")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("英音")
                            .font(.headline)
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(.orange)
                        
                        Spacer()
                        
                        Text("美音")
                            .font(.headline)
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(.orange)
                    }
                    
                    Text("n. 坦克, 水箱")
                        .font(.subheadline)
                    Text("n. 坦克, 水箱")
                        .font(.subheadline)
                    Text("n. 坦克, 水箱")
                        .font(.subheadline)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
                
                // 底部按钮
                HStack(spacing: 20) {
                    Button(action: {
                        // 添加到词汇表的操作
                    }) {
                        Text("Add to Vocabulary")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    
                    Button(action: {
                        // 选择语言的操作
                    }) {
                        Text("Choose Language: 中文")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
                
                
                // Bottom Navigation
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("User")
                            .font(.footnote)
                    }
                    Spacer()
                    VStack {
                        Image("Scan")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Text("Scan")
                            .font(.footnote)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Setting")
                            .font(.footnote)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
            }
            .navigationTitle("Vocabulary")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct VocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyView()
    }
}
