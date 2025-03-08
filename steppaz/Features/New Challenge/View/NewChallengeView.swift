////
////  NewChallengeView.swift
////  steppaz
////
////  Created by Godwin IE on 07/03/2025.
////
//
//import SwiftUI
//
//struct NewChallengeView: View {
//    //@StateObject private var viewModel = NewChallengeViewModel()
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Challenge Details")) {
//                    TextField("Title", text: $viewModel.title)
//                    
//                    TextEditor(text: $viewModel.description)
//                        .frame(height: 100)
//                    
//                    Stepper("Target: \(viewModel.targetSteps) steps", value: $viewModel.targetSteps, in: 1000...50000, step: 1000)
//                    
//                    Stepper("Duration: \(viewModel.duration) days", value: $viewModel.duration, in: 1...30)
//                    
//                    DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
//                }
//                
//                Section(header: Text("Invite Friends")) {
//                    NavigationLink(destination: FriendSelectionView(selectedFriends: $viewModel.selectedFriends)) {
//                        HStack {
//                            Text("Select Friends")
//                            Spacer()
//                            Text("\(viewModel.selectedFriends.count) selected")
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    
//                    if !viewModel.selectedFriends.isEmpty {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(viewModel.selectedFriends) { friend in
//                                    VStack {
//                                        ProfileAvatarView(user: friend, size: 40)
//                                        Text(friend.username ?? "User")
//                                            .font(.caption)
//                                    }
//                                    .padding(.trailing, 8)
//                                }
//                            }
//                            .padding(.vertical, 8)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("New Challenge")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Create") {
//                        Task {
//                            if await viewModel.createChallenge() {
//                                dismiss()
//                            }
//                        }
//                    }
//                    .disabled(viewModel.title.isEmpty || viewModel.isLoading)
//                }
//            }
//            .overlay {
//                if viewModel.isLoading {
//                    ProgressView()
//                        .background(Color.black.opacity(0.1))
//                        .ignoresSafeArea()
//                }
//            }
//        }
//    }
//}
